#!/usr/bin/swift

// TODO: trouver un moyen que ça fonctionne pour les nouveaux composants !! Ne pas prendre la branch main mais une autre branch ? Paramètre dans la GH Action ? (par défaut on prend main, sinon on prend la branch en paramètre

if CommandLine.argc < 2 {
    fatalError("No arguments are passed...")
} else {
    let package = CommandLine.arguments.last!
    print(package)

    let url = URL(filePath: "spark-ios/Package.swift")
    let dependencyContent = getDependencyContent(url, package: package)
    changeToLocalPackage(url, package: package, content: dependencyContent)
}

func getDependencyContent(_ url: URL, package: String) -> String {
    do {
        let text = try String(
            contentsOf: url,
            encoding: .utf8
        )

        if let dependencies = text.sliceMultipleTimes(from: "dependencies", to: "]").first {
            return dependencies.sliceMultipleTimes(from: ".package(", to: ")").compactMap {

                guard let name = $0.sliceMultipleTimes(from: "path: \"../", to: "\"").first,
                      package == name
                else {
                    return fatalError("No path found...")
                }

                return $0
            }
        } else {
            fatalError("No dependencies found...")
        }
    } catch {
        fatalError("Files can't be read...")
    }
}

func changeToLocalPackage(_ url: URL, package: String, content: String) {
    do {
        var text = try String(
            contentsOf: url,
            encoding: .utf8
        )

        let newContent = dependency.content
            .replacingOccurrences(
                of: "// path",
                with: "path"
            )
            .replacingOccurrences(
                of: "url",
                with: "// url"
            )
            .replacingOccurrences(
                of: "/*version*/ ",
                with: "// /*version*/ "
            )
            .replacingOccurrences(
                of: "../\(package)",
                with: "../"
            )

        text = text.replacingOccurrences(
            of: dependency.content,
            with: newContent
        )

        try text.write(
            to: url,
            atomically: false,
            encoding: .utf8
        )

        print("Package.swift is updated")

    } catch {
        fatalError("Files can't be read...")
    }
}

// MARK: - Extension

extension String {

    func sliceMultipleTimes(from: String, to: String) -> [String] {
        self.components(separatedBy: from).dropFirst().compactMap { sub in
            (sub.range(of: to)?.lowerBound).flatMap { endRange in
                String(sub[sub.startIndex ..< endRange])
            }
        }
    }
}

import Foundation

// MARK: - ResultsObjectChange

//
enum ResultsObjectChange: Equatable {
    case delete(indexPath: IndexPath)
    case insert(indexPath: IndexPath)
    case move(oldIndexPath: IndexPath, newIndexPath: IndexPath)
    case update(indexPath: IndexPath)
}

// MARK: - ResultsObjectChange: Transposing

//
extension ResultsObjectChange {
    /// Why? Because displaying data coming from multiple ResultsController onScreen... just requires us to adjust sectionIndexes
    ///
    func transpose(toSection section: Int) -> ResultsObjectChange {
        switch self {
        case let .delete(path):
            return .delete(indexPath: path.transpose(toSection: section))

        case let .insert(path):
            return .insert(indexPath: path.transpose(toSection: section))

        case let .move(oldPath, newPath):
            return .move(oldIndexPath: oldPath.transpose(toSection: section),
                         newIndexPath: newPath.transpose(toSection: section))

        case let .update(path):
            return .update(indexPath: path.transpose(toSection: section))
        }
    }
}

// MARK: - Equality

//
func == (lhs: ResultsObjectChange, rhs: ResultsObjectChange) -> Bool {
    switch (lhs, rhs) {
    case let (.delete(lPath), .delete(rPath)):
        return lPath == rPath
    case let (.insert(lPath), .insert(rPath)):
        return lPath == rPath
    case let (.move(lOldPath, lNewPath), .move(rOldPath, rNewPath)):
        return lOldPath == rOldPath && lNewPath == rNewPath
    case let (.update(lPath), .update(rPath)):
        return lPath == rPath
    default:
        return false
    }
}

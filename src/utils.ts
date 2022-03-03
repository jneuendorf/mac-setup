export function isString(object: any): object is string {
    return typeof object === 'string' || object instanceof String
}

export function isError(object: any): object is Error {
    return (
        object.name && isString(object.name)
        && object.message && isString(object.message)
    )
}
declare module "file-saver" {
  export function saveAs(
    data: Blob | string | MediaSource,
    filename?: string,
    options?: { type?: string; autoBom?: boolean }
  ): void;
}

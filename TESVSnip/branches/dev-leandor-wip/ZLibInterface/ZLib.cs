namespace TESVSnip.ZLibInterface
{
    using System;
    using System.IO;

    public static class ZLib
    {
        public static BinaryReader Decompress(byte[] buffer, int expectedSize = 0)
        {
            if (buffer == null) {
                throw new ArgumentNullException("buffer");
            }

            var output = new MemoryStream(expectedSize);
            try {
                using (var inflater = new DotZLib.Inflater()) {
                    inflater.DataAvailable += output.Write;
                    inflater.Add(buffer, 0, buffer.Length);
                }

                output.Position = 0;
                return new BinaryReader(output);
            }
            catch {
                output.Dispose();
                throw;
            }
        }

        public static BinaryReader Decompress(Stream input, int expectedSize = 0)
        {
            if (input == null) {
                throw new ArgumentNullException("input");
            }

            var buffer = new byte[input.Length];
            input.Read(buffer, 0, (int)input.Length);

            return Decompress(buffer, expectedSize);
        }
    }
}
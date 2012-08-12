namespace TESVSnip.ZLibInterface
{
    using System;
    using System.IO;

    public static class ZLib
    {
        public static string Version { get; private set; }

        public static void Initialize()
        {
            Version = DotZLib.Info.Version;
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

        public static byte[] Compress(Stream input)
        {
            if (input == null) {
                throw new ArgumentNullException("input");
            }

            var buffer = new byte[input.Length];
            input.Read(buffer, 0, (int)input.Length);

            return Compress(buffer);
        }

        public static byte[] Compress(byte[] input)
        {
            using (var output = new MemoryStream()) {
                using (var deflater = new DotZLib.Deflater(DotZLib.CompressLevel.Default)) {
                    deflater.DataAvailable += output.Write;
                    deflater.Add(input, 0, input.Length);
                }

                return output.ToArray();
            }
        }

        private static BinaryReader Decompress(byte[] buffer, int expectedSize = 0)
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
    }
}
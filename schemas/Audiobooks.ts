import { z } from "zod";
const schema = z.object({
  title: z.string(),
  runTimeMinutes: z.number(),
  type: z.string(),
  isBorrowable: z.boolean().optional(),
  categoryId: z.string().cuid(),
});

export type AudioBook = z.infer<typeof schema>;
export function validate(body: AudioBook) {
  return schema.safeParse(body);
}

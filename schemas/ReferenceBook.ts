import { z } from "zod";
const schema = z.object({
  title: z.string(),
  author: z.string(),
  nbrPages: z.number(),
  type: z.string(),
  isBorrowable: z.boolean().optional(),
  categoryId: z.string().cuid(),
});

export type ReferenceBook = z.infer<typeof schema>;
export function validate(body: ReferenceBook) {
  return schema.safeParse(body);
}

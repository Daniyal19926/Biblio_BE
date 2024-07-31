import { z } from "zod";
const schema = z.object({
  title: z.string(),
  author: z.string(),
  nbrPages: z.number(),
  type: z.string(),
  isBorrowable: z.boolean().optional(),
  borrowerId: z.string().optional(),
  categoryId: z.string().cuid(),
});

export type Book = z.infer<typeof schema>;
export function validate(body: Book) {
  return schema.safeParse(body);
}

import { z } from "zod";
const schema = z.object({
  title: z.string(),
  runTimeMinutes: z.number(),
  type: z.string(),
  isBorrowable: z.boolean().optional(),
  borrowerName: z.string().optional(),
  borrowDate: z.string().date().optional(),
  categoryId: z.string().cuid(),
});

export type Dvd = z.infer<typeof schema>;
export function validate(body: Dvd) {
  return schema.safeParse(body);
}

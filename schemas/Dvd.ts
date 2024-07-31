import { z } from "zod";
const schema = z
  .object({
    title: z.string(),
    runTimeMinuter: z.number(),
    type: z.string(),
    isBorrowable: z.boolean().optional(),
    categoryId: z.string().cuid(),
  })
  .strict();
export type Dvd = z.infer<typeof schema>;
export function validate(body: Dvd) {
  return schema.safeParse(body);
}

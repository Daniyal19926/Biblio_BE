import { z } from "zod";
const schema = z.object({
  name: z.string().min(3),
});
export type Category = z.infer<typeof schema>;
export function validate(body: Category) {
  return schema.safeParse(body);
}

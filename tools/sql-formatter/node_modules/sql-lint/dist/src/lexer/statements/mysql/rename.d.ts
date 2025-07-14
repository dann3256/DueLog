import { Query } from "../../../reader/query";
import { ILexer } from "../../interface";
declare class Rename implements ILexer {
    options: string[];
    tokenise(query: Query): Query;
}
export { Rename };

import { Link } from "@inertiajs/react";

export function renderCommaSeperatedLinks(linksItems) {
  return linksItems
    .map((link) => <Link key={link.href} className="text-blue-500" href={link.href}>{link.label}</Link>)
    .reduce((prev, curr) => [prev, ", ", curr]);
}

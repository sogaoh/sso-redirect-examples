export const Parallels = <T>(ps = new Set<Promise<T>>()) => ({
  add: (p: Promise<T>) => ps.add(!!p.then(() => ps.delete(p)).catch(() => ps.delete(p)) && p),
  all: () => Promise.all(ps),
})

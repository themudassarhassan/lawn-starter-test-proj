export function CenterContainer({ children }) {
  return (
    <div className="flex items-center justify-center min-h-[491px]">
      <div className="text-center text-gray-500">
        {children}
      </div>
    </div>
  )
}

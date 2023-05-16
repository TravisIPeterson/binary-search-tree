class Node
    attr_accessor :data, :left, :right

    def initialize(data)
        @data = data
        @left = nil
        @right = nil
    end

end

class Tree
    attr_accessor :data, :root

    def initialize(array)
        @data = array.sort.uniq
        @root = build_tree(data)
    end

    def build_tree(array)
        return nil if array.empty?

        mid = (array.length / 2).round

        root = Node.new(array[mid])

        root.left = build_tree(array[0...mid])
        root.right = build_tree(array[(mid + 1)..-1])

        root
    end

    def insert(value, node = root)
        if value == node.data
            return nil
        elsif value < node.data
            node.left.nil? ? node.left = Node.new(value) : insert(value, node.left)
        else
            node.right.nil? ? node.right = Node.new(value) : insert(value, node.right)
        end
    end

    def min(node)
        current_node = node
        current_node = current_node.left unless current_node.left.nil?
        current_node
    end

    def delete(value, node = root)
        if node.nil?
            return node
        elsif value < node.data
            node.left = delete(value, node.left)
        elsif value > node.data
            node.right = delete(value, node.right)
        elsif value == node.data
            if node.left.nil? && node.right.nil?
                node = nil
            elsif node.left.nil?
                node = node.right
            elsif node.right.nil?
                node = node.left
            else
                int = min(node.right)
                node.right = delete(int, node.right)
            end
        end

        node
    end

    def find(value, node = root)
        return nil if node.nil?
        return node if node.data == value

        value < node.data ? find(value, node.left) : find(value, node.right)
    end

    def pretty_print(node = @root, prefix = '', is_left = true)
        pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
        puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
        pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
    end

end

array = (Array.new(24) { rand(1..100)})

tree = Tree.new(array)

puts tree.pretty_print

tree.insert(35)

tree.insert(37)

puts tree.pretty_print

tree.delete(48)

tree.delete(35)

puts tree.pretty_print

p tree.find(37)

p tree.find(107)
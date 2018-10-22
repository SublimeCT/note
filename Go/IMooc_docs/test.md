# 测试与性能调优

## 1. 测试

### 1.1 表格驱动测试
- 将测试数据与测试逻辑分离
- 明确的报错信息
- 可以部分失败

```bash
triangle/
├── main.go
└── triangle_test.go
```

main.go
```go
package main

import (
	"fmt"
	"math"
)

func CalcTriangle(a, b int) int {
	return int(math.Sqrt(float64(a*a + b*b)))
}

func main() {
	fmt.Printf(": %d", CalcTriangle(3, 4))
}
```

triangle_test.go
```go
package main

import (
	"testing"
)

func TestTriangle(t *testing.T) {
	testData := []struct{ a, b, c int }{
		{3, 4, 5},
		{5, 12, 13},
		{8, 15, 7},
	}

	for _, tt := range testData {
		if actual := CalcTriangle(tt.a, tt.b); actual != tt.c {
			t.Errorf("\nCalcTriangle(%d, %d): got %d, expected %d\n", tt.a, tt.b, actual, tt.c)
		}
	}
}
```

```bash
$ go test .
```


# Commit Message Templates

Use these templates as references when generating commit messages.

**Note**: This skill has zero script dependencies. All parsing logic (PMS URLs, Issue URLs) is handled by the AI directly through natural language understanding and git commands.

## Examples

### Feature Addition

```
feat: add JWT authentication middleware

1. Implement JWT-based authentication with token validation logic.
2. Add refresh token rotation support.
3. Register auth middleware in the request pipeline.

Log: Add JWT authentication to the API layer

Influence:
1. Verify all authenticated endpoints require valid JWT token.
2. Test token refresh flow with expired and valid tokens.
3. Confirm middleware registration order is correct.

feat: 添加JWT认证中间件

1. 实现基于JWT的认证逻辑，支持令牌验证。
2. 添加刷新令牌轮换支持。
3. 在请求管道中注册认证中间件。

Log: 添加JWT认证中间件

Influence:
1. 验证所有认证接口要求有效JWT令牌。
2. 测试令牌刷新流程，包括过期和有效令牌场景。
3. 确认中间件注册顺序正确。

PMS: TASK-385999
Fixes: #183
```

### Bug Fix

fix: resolve incorrect role assignment mapping

1. Use correct role key mapping from database configuration.
2. Add validation for unknown role IDs.
3. Log warning on unrecognized role assignments.

Log: Fix role mapping bug

Influence:
1. Verify user role assignment matches database configuration.
2. Test edge cases with missing or invalid role IDs.
3. Confirm warning logs appear for unrecognized roles.

fix: 修复用户角色映射错误

1. 使用正确的数据库配置映射进行角色分配。
2. 添加对未知角色ID的验证。
3. 对无法识别的角色分配记录警告日志。

Log: 修复角色映射bug

Influence:
1. 验证用户角色分配与数据库配置一致。
2. 测试缺失或无效角色ID的边界情况。
3. 确认无法识别的角色触发警告日志。

### Documentation

```
docs: update installation guide for Linux arm64

1. Add detailed instructions for ARM64 architecture.
2. Document dependency requirements for arm64.
3. Include troubleshooting section for common issues.

Log: Update ARM64 installation documentation

Influence:
1. Follow the guide to install on ARM64 from scratch.
2. Verify all dependency commands execute without errors.
3. Test each troubleshooting step reproduces correctly.

docs: 更新Linux ARM64安装指南

1. 添加ARM64架构的详细安装说明。
2. 记录ARM64的依赖要求。
3. 包含常见问题的故障排查章节。

Log: 更新ARM64安装文档

Influence:
1. 按照指南在ARM64上从头安装验证。
2. 确认所有依赖命令无错误执行。
3. 测试每个故障排查步骤是否正确。
```

### Performance Improvement

```
perf: optimize database query with pagination

1. Add pagination to reduce memory usage on large datasets.
2. Implement cursor-based iteration for batch processing.
3. Add query timeout to prevent long-running queries.

Log: Optimize database query performance

Influence:
1. Run query on 10k+ record dataset — verify response time < 500ms.
2. Confirm memory usage is reduced by ~60%.
3. Test pagination edge cases: page 1, last page, empty page.

perf: 优化数据库查询性能

1. 添加分页减少大数据集的内存占用。
2. 实现基于游标的批量处理迭代。
3. 添加查询超时防止长时间运行。

Log: 优化数据库查询性能

Influence:
1. 在1万+记录的数据集上运行，验证响应时间<500ms。
2. 确认内存占用降低约60%。
3. 测试分页边界：第一页、最后一页、空页。

PMS: TASK-456789
Fixes: #204
```

### Refactoring

refactor: extract common validation logic to utils module

1. Move duplicate validation rules from endpoints to shared utility.
2. Standardize error response structure.
3. Remove dead code from legacy validation paths.

Log: No user-facing changes

Influence:
1. Verify all endpoints still return correct validation errors.
2. Run existing test suite — no regressions expected.
3. Confirm no unused imports or orphaned functions remain.

refactor: 提取通用验证逻辑到工具模块

1. 将重复的验证规则从多个端点提取到共享工具类。
2. 标准化错误响应结构。
3. 删除旧的验证路径中的死代码。

Log: 无用户可见变化

Influence:
1. 验证所有端点仍然返回正确的验证错误。
2. 运行现有测试套件——预期无回归。
3. 确认没有未使用的导入或孤立函数残留。

### Test Coverage

```
test: add unit tests for JWT token validation

1. Cover expired tokens, invalid signatures, malformed payloads.
2. Add integration test for auth middleware pipeline.
3. Verify error responses match expected schema.

Log: No user-facing changes

Influence:
1. Run test suite — all new tests pass.
2. Verify coverage report shows >90% for auth module.
3. Confirm edge cases: null token, empty string, garbage input.

test: 添加JWT令牌验证单元测试

1. 覆盖过期令牌、无效签名、格式错误载荷。
2. 添加认证中间件管道的集成测试。
3. 验证错误响应符合预期模式。

Log: 无用户可见变化

Influence:
1. 运行测试套件——所有测试通过。
2. 验证覆盖率报告显示认证模块>90%。
3. 确认边界情况处理：空令牌、空字符串、垃圾输入。

Fixes: #251
```

### CI/CD

```
ci: add automated testing workflow on PR

1. Configure GitHub Actions to run test suite on every PR.
2. Integrate code coverage reporting.
3. Add linting step to prevent style violations.

Log: Add CI test workflow for pull requests

Influence:
1. Open a test PR — verify workflow triggers automatically.
2. Check coverage report is generated and uploaded.
3. Confirm lint step fails on intentional style violation.

ci: 添加PR自动测试工作流

1. 配置GitHub Actions在每个PR上运行测试套件。
2. 集成代码覆盖率报告。
3. 添加代码检查步骤防止风格违规。

Log: 添加PR自动测试工作流

Influence:
1. 开启测试PR——验证工作流自动触发。
2. 检查覆盖率报告是否生成并上传。
3. 确认代码检查步骤在有意违规时失败。

PMS: TASK-789012
```

### Chore

```
chore: upgrade dependencies to latest stable versions

1. Update Rust crates to latest compatible versions.
2. Fix breaking changes from dependency updates.
3. Remove unused dependencies from Cargo.toml.

Log: No user-facing changes

Influence:
1. Run `cargo build` — verify clean compilation.
2. Run test suite — all tests pass with new deps.
3. Confirm security advisories for old versions are resolved.

chore: 升级依赖到最新稳定版本

1. 更新Rust依赖到最新兼容版本。
2. 修复依赖更新导致的破坏性变更。
3. 从Cargo.toml中移除未使用的依赖。

Log: 无用户可见变化

Influence:
1. 运行`cargo build`——确认编译无警告。
2. 运行测试套件——所有测试在新依赖下通过。
3. 确认旧版本的安全公告已解决。

PMS: TASK-345678
```


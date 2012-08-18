pushd (Split-Path -Path $MyInvocation.MyCommand.Definition -Parent)

if (!(Test-Path '..\..\libgit2sharp\Build'))
{
    throw 'Could not find local libgit2sharp build'
}

copy -Force ..\..\libgit2sharp\Build\libgit2sharp.dll .\
copy -Force ..\..\libgit2sharp\Build\libgit2sharp.pdb .\
copy -Force ..\..\libgit2sharp\Build\libgit2sharp.xml .\
copy -Force -Recurse ..\..\libgit2sharp\Build\NativeBinaries .\

popd
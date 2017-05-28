

Your co-worker, Tomer, wants to mirror and snapshot the Extra Packages for
Enterprise Linux (EPEL) nightly. This way when a dependency breaks in EPEL,
Tomer can revert the CI/CD pipeline to use the older, good packages. To do
this, Tomer is using Pulp [0] which can mirror and version repositories of
content like RPMs.

Tomer finished the dnf installation of Pulp, and there were some errors about
the pulp-celery SELinux policy. Pulp is a multi-process application and when
starting three of its processes, `pulp_celerybeat`, `pulp_resource_manager`,
and `pulp_workers` they refuse to start with an error message like:

    pulp_resource_manager.service: Failed at step EXEC spawning /usr/bin/celery: Permission denied

Tomer thinks the issue is something SELinux related because if he disables
SELinux, the processes start normally. Tomer asks you if you can take a look
since the normal SELinux guy is on vacation in Disney World. You comment that
he always seems to be on vacation when you need him. Reluctantly, you agree to
try to fix it.

Objective:

* With SELinux enabled, start `pulp_celerybeat`, `pulp_resource_manager`, and
  `pulp_workers`. Here is a helpful one liner to restart those three
  processes:

    for s in {pulp_celerybeat,pulp_resource_manager,pulp_workers}; do sudo systemctl restart $s; done

* After Pulp is running sync a basic yum repository called the 'zoo' repo [1]
  with the following three commands:

    pulp-admin login -u admin -p admin
    pulp-admin rpm repo create --repo-id zoo --feed https://repos.fedorapeople.org/repos/pulp/pulp/fixtures/rpm/
    pulp-admin rpm repo sync run --repo-id zoo

[0]: http://pulpproject.org/
[1]: https://repos.fedorapeople.org/repos/pulp/pulp/fixtures/rpm/


From: Goncalo Borges <goncalo-JAjqph6Yjy/r8pF6qxatHrpzq4S04n8Q@public.gmane.org>
Subject: Re: v9.1.0 Infernalis release candidate released
Date: Thu, 15 Oct 2015 10:56:26 +1100
Message-ID: <561EEBAA.6070707@physics.usyd.edu.au>
References: <alpine.DEB.2.00.1510131356001.27022@cobra.newdream.net>
	<561DDF65.7080001@physics.usyd.edu.au>
	<CABZ+qq=a1y6vVk9sVuW0w=NV1zPas+nW-vRtfgywRMFtJBf_sQ@mail.gmail.com>
	<alpine.DEB.2.00.1510140527120.6589@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <alpine.DEB.2.00.1510140527120.6589-vIokxiIdD2AQNTJnQDzGJqxOck334EZe@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org>, Dan van der Ster <dan-EOCVfBHj35C+XT7JhA+gdA@public.gmane.org>
Cc: "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ceph-users <ceph-users-Qp0mS5GaXlQ@public.gmane.org>, ceph-maintainers-Qp0mS5GaXlQ@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

Hi Sage, Dan...

In our case, we have strongly invested in the testing of CephFS. It 
seems as a good solution to some of the issues we currently experience 
regarding the use cases from our researchers.

While I do not see a problem in deploying Ceph cluster in SL7, I suspect 
that we will need CephFS clients in SL6 for quite some time. The problem 
here is that our researchers use a whole bunch of software provided by 
the CERN experiments to generate MC data or analyse experimental data. 
This software is currently certified for SL6 and I think that a SL7 
version will take a considerable amount of time. So we need a CephFS 
client that allows our researchers to access and analyse the data in 
that environment.

If you guys did not think it was worthwhile the effort to built for 
those flavors, that actually tells me this is a complicated task that, 
most probably, I can not do it on my own.

I am currently interacting with Dan and other colleagues in a CERN 
mailing list. Let us see what would be the outcome of that discussion.

But at the moment I am open to suggestions.

TIA
Goncalo

On 10/14/2015 11:30 PM, Sage Weil wrote:
> On Wed, 14 Oct 2015, Dan van der Ster wrote:
>> Hi Goncalo,
>>
>> On Wed, Oct 14, 2015 at 6:51 AM, Goncalo Borges
>> <goncalo-JAjqph6Yjy/r8pF6qxatHrpzq4S04n8Q@public.gmane.org> wrote:
>>> Hi Sage...
>>>
>>> I've seen that the rh6 derivatives have been ruled out.
>>>
>>> This is a problem in our case since the OS choice in our systems is,
>>> somehow, imposed by CERN. The experiments software is certified for SL6 and
>>> the transition to SL7 will take some time.
>> Are you accessing Ceph directly from "physics" machines? Here at CERN
>> we run CentOS 7 on the native clients (e.g. qemu-kvm hosts) and by the
>> time we upgrade to Infernalis the servers will all be CentOS 7 as
>> well. Batch nodes running SL6 don't (currently) talk to Ceph directly
>> (in the future they might talk to Ceph-based storage via an xroot
>> gateway). But if there are use-cases then perhaps we could find a
>> place to build and distributing the newer ceph clients.
>>
>> There's a ML ceph-talk-vJEk5272eHo@public.gmane.org where we could take this discussion.
>> Mail me if have trouble joining that e-Group.
> Also note that it *is* possible to build infernalis on el6, but it
> requires a lot more effort... enough that we would rather spend our time
> elsewhere (at least as far as ceph.com packages go).  If someone else
> wants to do that work we'd be happy to take patches to update the and/or
> release process.
>
> IIRC the thing that eventually made me stop going down this patch was the
> fact that the newer gcc had a runtime dependency on the newer libstdc++,
> which wasn't part of the base distro... which means we'd need also to
> publish those packages in the ceph.com repos, or users would have to
> add some backport repo or ppa or whatever to get things running.  Bleh.
>
> sage
>
>
>> Cheers, Dan
>> CERN IT-DSS
>>
>>> This is kind of a showstopper specially if we can't deploy clients in SL6 /
>>> Centos6.
>>>
>>> Is there any alternative?
>>>
>>> TIA
>>> Goncalo
>>>
>>>
>>>
>>> On 10/14/2015 08:01 AM, Sage Weil wrote:
>>>> This is the first Infernalis release candidate.  There have been some
>>>> major changes since hammer, and the upgrade process is non-trivial.
>>>> Please read carefully.
>>>>
>>>> Getting the release candidate
>>>> -----------------------------
>>>>
>>>> The v9.1.0 packages are pushed to the development release repositories::
>>>>
>>>>     http://download.ceph.com/rpm-testing
>>>>     http://download.ceph.com/debian-testing
>>>>
>>>> For for info, see::
>>>>
>>>>     http://docs.ceph.com/docs/master/install/get-packages/
>>>>
>>>> Or install with ceph-deploy via::
>>>>
>>>>     ceph-deploy install --testing HOST
>>>>
>>>> Known issues
>>>> ------------
>>>>
>>>> * librbd and librados ABI compatibility is broken.  Be careful
>>>>     installing this RC on client machines (e.g., those running qemu).
>>>>     It will be fixed in the final v9.2.0 release.
>>>>
>>>> Major Changes from Hammer
>>>> -------------------------
>>>>
>>>> * *General*:
>>>>     * Ceph daemons are now managed via systemd (with the exception of
>>>>       Ubuntu Trusty, which still uses upstart).
>>>>     * Ceph daemons run as 'ceph' user instead root.
>>>>     * On Red Hat distros, there is also an SELinux policy.
>>>> * *RADOS*:
>>>>     * The RADOS cache tier can now proxy write operations to the base
>>>>       tier, allowing writes to be handled without forcing migration of
>>>>       an object into the cache.
>>>>     * The SHEC erasure coding support is no longer flagged as
>>>>       experimental. SHEC trades some additional storage space for faster
>>>>       repair.
>>>>     * There is now a unified queue (and thus prioritization) of client
>>>>       IO, recovery, scrubbing, and snapshot trimming.
>>>>     * There have been many improvements to low-level repair tooling
>>>>       (ceph-objectstore-tool).
>>>>     * The internal ObjectStore API has been significantly cleaned up in
>>>> order
>>>>       to faciliate new storage backends like NewStore.
>>>> * *RGW*:
>>>>     * The Swift API now supports object expiration.
>>>>     * There are many Swift API compatibility improvements.
>>>> * *RBD*:
>>>>     * The ``rbd du`` command shows actual usage (quickly, when
>>>>       object-map is enabled).
>>>>     * The object-map feature has seen many stability improvements.
>>>>     * Object-map and exclusive-lock features can be enabled or disabled
>>>>       dynamically.
>>>>     * You can now store user metadata and set persistent librbd options
>>>>       associated with individual images.
>>>>     * The new deep-flatten features allows flattening of a clone and all
>>>>       of its snapshots.  (Previously snapshots could not be flattened.)
>>>>     * The export-diff command command is now faster (it uses aio).  There
>>>> is also
>>>>       a new fast-diff feature.
>>>>     * The --size argument can be specified with a suffix for units
>>>>       (e.g., ``--size 64G``).
>>>>     * There is a new ``rbd status`` command that, for now, shows who has
>>>>       the image open/mapped.
>>>> * *CephFS*:
>>>>     * You can now rename snapshots.
>>>>     * There have been ongoing improvements around administration,
>>>> diagnostics,
>>>>       and the check and repair tools.
>>>>     * The caching and revocation of client cache state due to unused
>>>>       inodes has been dramatically improved.
>>>>     * The ceph-fuse client behaves better on 32-bit hosts.
>>>>
>>>> Distro compatibility
>>>> --------------------
>>>>
>>>> We have decided to drop support for many older distributions so that we
>>>> can
>>>> move to a newer compiler toolchain (e.g., C++11).  Although it is still
>>>> possible
>>>> to build Ceph on older distributions by installing backported development
>>>> tools,
>>>> we are not building and publishing release packages for ceph.com.
>>>>
>>>> In particular,
>>>>
>>>> * CentOS 7 or later; we have dropped support for CentOS 6 (and other
>>>>     RHEL 6 derivatives, like Scientific Linux 6).
>>>> * Debian Jessie 8.x or later; Debian Wheezy 7.x's g++ has incomplete
>>>>     support for C++11 (and no systemd).
>>>> * Ubuntu Trusty 14.04 or later; Ubuntu Precise 12.04 is no longer
>>>>     supported.
>>>> * Fedora 22 or later.
>>>>
>>>> Upgrading from Firefly
>>>> ----------------------
>>>>
>>>> Upgrading directly from Firefly v0.80.z is not possible.  All clusters
>>>> must first upgrade to Hammer v0.94.4 or a later v0.94.z release; only
>>>> then is it possible to upgrade to Infernalis 9.2.z.
>>>>
>>>> Note that v0.94.4 isn't released yet, but you can upgrade to a test build
>>>> from gitbuilder with::
>>>>
>>>>     ceph-deploy install --dev hammer HOST
>>>>
>>>> The v0.94.4 Hammer point release will be out before v9.2.0 Infernalis
>>>> is.
>>>>
>>>> Upgrading from Hammer
>>>> ---------------------
>>>>
>>>> * For all distributions that support systemd (CentOS 7, Fedora, Debian
>>>>     Jessie 8.x, OpenSUSE), ceph daemons are now managed using native
>>>> systemd
>>>>     files instead of the legacy sysvinit scripts.  For example,::
>>>>
>>>>       systemctl start ceph.target       # start all daemons
>>>>       systemctl status ceph-osd@12      # check status of osd.12
>>>>
>>>>     The main notable distro that is *not* yet using systemd is Ubuntu
>>>> trusty
>>>>     14.04.  (The next Ubuntu LTS, 16.04, will use systemd instead of
>>>> upstart.)
>>>>       * Ceph daemons now run as user and group ``ceph`` by default.  The
>>>>     ceph user has a static UID assigned by Fedora and Debian (also used
>>>>     by derivative distributions like RHEL/CentOS and Ubuntu).  On SUSE
>>>>     the ceph user will currently get a dynamically assigned UID when the
>>>>     user is created.
>>>>
>>>>     If your systems already have a ceph user, upgrading the package will
>>>> cause
>>>>     problems.  We suggest you first remove or rename the existing 'ceph'
>>>> user
>>>>     before upgrading.
>>>>
>>>>     When upgrading, administrators have two options:
>>>>
>>>>      #. Add the following line to ``ceph.conf`` on all hosts::
>>>>
>>>>           setuser match path = /var/lib/ceph/$type/$cluster-$id
>>>>
>>>>         This will make the Ceph daemons run as root (i.e., not drop
>>>>         privileges and switch to user ceph) if the daemon's data
>>>>         directory is still owned by root.  Newly deployed daemons will
>>>>         be created with data owned by user ceph and will run with
>>>>         reduced privileges, but upgraded daemons will continue to run as
>>>>         root.
>>>>
>>>>      #. Fix the data ownership during the upgrade.  This is the preferred
>>>> option,
>>>>         but is more work.  The process for each host would be to:
>>>>
>>>>         #. Upgrade the ceph package.  This creates the ceph user and group.
>>>> For
>>>>           example::
>>>>
>>>>             ceph-deploy install --stable infernalis HOST
>>>>
>>>>         #. Stop the daemon(s).::
>>>>
>>>>             service ceph stop           # fedora, centos, rhel, debian
>>>>             stop ceph-all               # ubuntu
>>>>
>>>>         #. Fix the ownership::
>>>>
>>>>             chown -R ceph:ceph /var/lib/ceph
>>>>
>>>>         #. Restart the daemon(s).::
>>>>
>>>>             start ceph-all                # ubuntu
>>>>             systemctl start ceph.target   # debian, centos, fedora, rhel
>>>>
>>>> * The on-disk format for the experimental KeyValueStore OSD backend has
>>>>     changed.  You will need to remove any OSDs using that backend before
>>>> you
>>>>     upgrade any test clusters that use it.
>>>>
>>>> Upgrade notes
>>>> -------------
>>>>
>>>> * When a pool quota is reached, librados operations now block
>>>> indefinitely,
>>>>     the same way they do when the cluster fills up.  (Previously they would
>>>> return
>>>>     -ENOSPC).  By default, a full cluster or pool will now block.  If your
>>>>     librados application can handle ENOSPC or EDQUOT errors gracefully, you
>>>> can
>>>>     get error returns instead by using the new librados OPERATION_FULL_TRY
>>>> flag.
>>>>
>>>> Notable changes
>>>> ---------------
>>>>
>>>> NOTE: These notes are somewhat abbreviated while we find a less
>>>> time-consuming process for generating them.
>>>>
>>>> * build: C++11 now supported
>>>> * build: many cmake improvements
>>>> * build: OSX build fixes (Yan, Zheng)
>>>> * build: remove rest-bench
>>>> * ceph-disk: many fixes (Loic Dachary)
>>>> * ceph-disk: support for multipath devices (Loic Dachary)
>>>> * ceph-fuse: mostly behave on 32-bit hosts (Yan, Zheng)
>>>> * ceph-objectstore-tool: many improvements (David Zafman)
>>>> * common: bufferlist performance tuning (Piotr Dalek, Sage Weil)
>>>> * common: make mutex more efficient
>>>> * common: some async compression infrastructure (Haomai Wang)
>>>> * librados: add FULL_TRY and FULL_FORCE flags for dealing with full
>>>> clusters or pools (Sage Weil)
>>>> * librados: fix notify completion race (#13114 Sage Weil)
>>>> * librados, libcephfs: randomize client nonces (Josh Durgin)
>>>> * librados: pybind: fix binary omap values (Robin H. Johnson)
>>>> * librbd: fix reads larger than the cache size (Lu Shi)
>>>> * librbd: metadata filter fixes (Haomai Wang)
>>>> * librbd: use write_full when possible (Zhiqiang Wang)
>>>> * mds: avoid emitting cap warnigns before evicting session (John Spray)
>>>> * mds: fix expected holes in journal objects (#13167 Yan, Zheng)
>>>> * mds: fix SnapServer crash on deleted pool (John Spray)
>>>> * mds: many fixes (Yan, Zheng, John Spray, Greg Farnum)
>>>> * mon: add cache over MonitorDBStore (Kefu Chai)
>>>> * mon: 'ceph osd metadata' can dump all osds (Haomai Wang)
>>>> * mon: detect kv backend failures (Sage Weil)
>>>> * mon: fix CRUSH map test for new pools (Sage Weil)
>>>> * mon: fix min_last_epoch_clean tracking (Kefu Chai)
>>>> * mon: misc scaling fixes (Sage Weil)
>>>> * mon: streamline session handling, fix memory leaks (Sage Weil)
>>>> * mon: upgrades must pass through hammer (Sage Weil)
>>>> * msg/async: many fixes (Haomai Wang)
>>>> * osd: cache proxy-write support (Zhiqiang Wang, Samuel Just)
>>>> * osd: configure promotion based on write recency (Zhiqiang Wang)
>>>> * osd: don't send dup MMonGetOSDMap requests (Sage Weil, Kefu Chai)
>>>> * osd: erasure-code: fix SHEC floating point bug (#12936 Loic Dachary)
>>>> * osd: erasure-code: update to ISA-L 2.14 (Yuan Zhou)
>>>> * osd: fix hitset object naming to use GMT (Kefu Chai)
>>>> * osd: fix misc memory leaks (Sage Weil)
>>>> * osd: fix peek_queue locking in FileStore (Xinze Chi)
>>>> * osd: fix promotion vs full cache tier (Samuel Just)
>>>> * osd: fix replay requeue when pg is still activating (#13116 Samuel Just)
>>>> * osd: fix scrub stat bugs (Sage Weil, Samuel Just)
>>>> * osd: force promotion for ops EC can't handle (Zhiqiang Wang)
>>>> * osd: improve behavior on machines with large memory pages (Steve Capper)
>>>> * osd: merge multiple setattr calls into a setattrs call (Xinxin Shu)
>>>> * osd: newstore prototype (Sage Weil)
>>>> * osd: ObjectStore internal API refactor (Sage Weil)
>>>> * osd: SHEC no longer experimental
>>>> * osd: throttle evict ops (Yunchuan Wen)
>>>> * osd: upgrades must pass through hammer (Sage Weil)
>>>> * osd: use SEEK_HOLE / SEEK_DATA for sparse copy (Xinxin Shu)
>>>> * rbd: rbd-replay-prep and rbd-replay improvements (Jason Dillaman)
>>>> * rgw: expose the number of unhealthy workers through admin socket (Guang
>>>> Yang)
>>>> * rgw: fix casing of Content-Type header (Robin H. Johnson)
>>>> * rgw: fix decoding of X-Object-Manifest from GET on Swift DLO (Radslow
>>>> Rzarzynski)
>>>> * rgw: fix sysvinit script
>>>> * rgw: fix sysvinit script w/ multiple instances (Sage Weil, Pavan
>>>> Rallabhandi)
>>>> * rgw: improve handling of already removed buckets in expirer (Radoslaw
>>>> Rzarzynski)
>>>> * rgw: log to /var/log/ceph instead of /var/log/radosgw
>>>> * rgw: rework X-Trans-Id header to be conform with Swift API (Radoslaw
>>>> Rzarzynski)
>>>> * rgw: s3 encoding-type for get bucket (Jeff Weber)
>>>> * rgw: set max buckets per user in ceph.conf (Vikhyat Umrao)
>>>> * rgw: support for Swift expiration API (Radoslaw Rzarzynski, Yehuda
>>>> Sadeh)
>>>> * rgw: user rm is idempotent (Orit Wasserman)
>>>> * selinux policy (Boris Ranto, Milan Broz)
>>>> * systemd: many fixes (Sage Weil, Owen Synge, Boris Ranto, Dan van der
>>>> Ster)
>>>> * systemd: run daemons as user ceph
>>>>
>>>> Getting Ceph
>>>> ------------
>>>>
>>>> * Git at git://github.com/ceph/ceph.git
>>>> * Tarball at http://download.ceph.com/tarballs/ceph-9.1.0.tar.gz
>>>> * For packages, see http://ceph.com/docs/master/install/get-packages
>>>> * For ceph-deploy, see
>>>> http://ceph.com/docs/master/install/install-ceph-deploy
>>>> _______________________________________________
>>>> ceph-users mailing list
>>>> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
>>>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>>>
>>> --
>>> Goncalo Borges
>>> Research Computing
>>> ARC Centre of Excellence for Particle Physics at the Terascale
>>> School of Physics A28 | University of Sydney, NSW  2006
>>> T: +61 2 93511937
>>>
>>>
>>> _______________________________________________
>>> ceph-users mailing list
>>> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
>>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>

-- 
Goncalo Borges
Research Computing
ARC Centre of Excellence for Particle Physics at the Terascale
School of Physics A28 | University of Sydney, NSW  2006
T: +61 2 93511937

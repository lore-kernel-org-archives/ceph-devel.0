From: John Spray <jspray-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: can we drop support of centos/rhel 7.4?
Date: Fri, 14 Sep 2018 15:07:38 +0100
Message-ID: <CALe9h7dPckkK2smbQugbnHa9p92nPju6voP3s24dMkUUmFoheg@mail.gmail.com>
References: <CAJE9aONakRfTc_ghzj_6wie4CcnD6KNMgMHtaZMbK5LbiLyn7A@mail.gmail.com>
 <CALe9h7cNdS2wffQLO2Gsud3xY7fA5KhfUUKWvDDXGMWYPGhpiA@mail.gmail.com>
 <CAN-GepL6d3foa62i7NDuwjUS51hAnu_mrntPqyMKTS9bwqPH3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAN-GepL6d3foa62i7NDuwjUS51hAnu_mrntPqyMKTS9bwqPH3Q-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: David Turner <drakonstein-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Ceph Development <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

On Fri, Sep 14, 2018 at 2:26 PM David Turner <drakonstein-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>
> Release dates
> RHEL 7.4 - July 2017
> Luminous 12.2.0 - August 2017
> CentOS 7.4 - September 2017
> RHEL 7.5 - April 2018
> CentOS 7.5 - May 2018
> Mimic 13.2.0 - June 2018
>
> In the world of sysadmins it takes time to let new releases/OS's simmer before beginning to test them let alone upgrading to them. It is not possible to tell all companies that use CentOS that we have to move to a new OS upgrade 5 months after it is released. We are still testing if CentOS 7.5 works in our infrastructure in general let alone being up and running on it. The kernel upgrades alone are a big change now to mention the obvious package version changes. We don't even have the OK to install it in staging. Once we do, and we have the time to start testing it, ...among our other tasks, we can start regression testing our use case in staging before thinking about upgrading prod.
>
> That time frame isn't really so bad if everything is working great for ceph, but what if we're waiting on 12.2.9 and 13.2.2 for a bugfix that's giving us grief? Now we are not only dealing with the bugs, but now we have to regression test an OS upgrade, update our package management, and make sure our new deployments will have this version... And then we can start regression testing the new release that hopefully fixes the bugs we're dealing with...

From the comments on http://tracker.ceph.com/issues/35969, I think
Kefu is still proposing to work around this in Ceph's build (i.e. to
fix this so that our packages still work on centOS 7.4).

Ideally, distros maintain ABI compatibility such that the packages we
test on one minor version will also work on another -- that hasn't
happened in the 7.4->7.5 transition for gperftools.  That's annoying,
but it's also kind of a special case, and we hopefully won't encounter
issues like this particularly frequently within a major release.  If
we move away from using 7.4 for the main build/test cycle, that
doesn't mean we wouldn't also be accepting fixes to keep it working on
older releases (although it of course relies on someone noticing
if/when it breaks).

> What about backporting the API standards to the CentOS 7.4 version of gperftools-libs?
>
> I've noticed little package issues like this in the past, but assumed that was because most development was done on Ubuntu instead of RHEL. We had to set our repos to a newer version of CentOS than we were running or willing to upgrade to just for a single package we needed. If y'all are really thinking of only supporting/testing the latest dot release of the latest major version of RHEL, then you might have just given me the fuel to be able to finally convince my company into allowing us to be the first application in 9,000 servers to not run CentOS. I've been trying to get them to allow it for a while because of the previous package issues, but I hadn't put much effort into it because I thought/hoped those problems might be behind us...
>
> Do y'all not test ceph on 7.3 right now? This email thread really might be enough to get us off of CentOS for Ceph.

There is a set of permutations in qa/distros, used in
qa/suites/buildpackages/ -- I'm not sure exactly what's run when
though (possibly some only at release time?), perhaps someone more
familiar with exactly what tests are run before a release could chime
in.

John

>
> On Fri, Sep 14, 2018, 5:49 AM John Spray <jspray-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
>>
>> On Fri, Sep 14, 2018 at 3:48 AM kefu chai <tchaikov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>> >
>> > hi ceph-{maintainers,users,developers},
>> >
>> > recently, i ran into an issue[0] which popped up when we build Ceph on
>> > centos 7.5, but test it on centos 7.4. as we know, the gperftools-libs
>> > package provides the tcmalloc allocator shared library, but centos 7.4
>> > and centos 7.5 ship different version of gperftools-{devel,libs}. the
>> > former ships 2.4, and the latter 2.6.1.
>> >
>> > the crux is that the tcmalloc in gperftools 2.6.1 implements more
>> > standard compliant C++ APIs, which were missing in gperftools 2.4.
>> > that's why we have failures like:
>> >
>> > ceph-osd: symbol lookup error: ceph-osd: undefined symbol: _ZdaPvm
>> >
>> > when testing Ceph on centos 7.4.
>> >
>> > my question is: is it okay to drop the support of centos/rhel 7.4? so
>> > we will solely build and test the supported Ceph releases (luminous,
>> > mimic) on 7.5 ?
>>
>> My preference would be to target the latest minor release (i.e. 7.5)
>> of the major release.  We don't test on CentOS 7.1, 7.2 etc, so I
>> don't think we need to give 7.4 any special treatment.
>>
>> John
>>
>> >
>> > thanks,
>> >
>> > --
>> > [0] http://tracker.ceph.com/issues/35969
>> >
>> > --
>> > Regards
>> > Kefu Chai
>> _______________________________________________
>> ceph-users mailing list
>> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

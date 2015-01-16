From: Sage Weil <sweil@redhat.com>
Subject: Re: New Defects reported by Coverity Scan for ceph
Date: Fri, 16 Jan 2015 08:08:47 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1501160807590.26676@cobra.newdream.net>
References: <54b922af592d5_4b8dd69318255c1@scan.coverity.com.mail> <CAC6JEv9+HkQr2GbLHWQwV2ENcwg2wBciMn-akhGmDEtK+K3LqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58923 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754150AbbAPQIu (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 16 Jan 2015 11:08:50 -0500
In-Reply-To: <CAC6JEv9+HkQr2GbLHWQwV2ENcwg2wBciMn-akhGmDEtK+K3LqA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@gregs42.com>
Cc: John Spray <john.spray@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Yeah, there's a pile of these warnings for most/all of the binaries we 
build.  Not sure if they are worth fixing or whether there is a coverity 
annotation we can add to suppress them..

s


On Fri, 16 Jan 2015, Gregory Farnum wrote:

> Sage, are these uncaught assertion errors something we normally
> ignore? I'm not familiar with any code that tries to catch errors in
> our standard init patterns, which is what looks to be the problem on
> these new coverity issues in cephfs-table-tool.
> -Greg
> 
> On Fri, Jan 16, 2015 at 6:39 AM,  <scan-admin@coverity.com> wrote:
> >
> > Hi,
> >
> > Please find the latest report on new defect(s) introduced to ceph found with Coverity Scan.
> >
> > 4 new defect(s) introduced to ceph found with Coverity Scan.
> > 19 defect(s), reported by Coverity Scan earlier, were marked fixed in the recent build analyzed by Coverity Scan.
> >
> > New defect(s) Reported-by: Coverity Scan
> > Showing 4 of 4 defect(s)
> >
> >
> > ** CID 1264457:  Uncaught exception  (UNCAUGHT_EXCEPT)
> > /tools/cephfs/cephfs-table-tool.cc: 11 in main()
> > /tools/cephfs/cephfs-table-tool.cc: 11 in main()
> > /tools/cephfs/cephfs-table-tool.cc: 11 in main()
> > /tools/cephfs/cephfs-table-tool.cc: 11 in main()
> > /tools/cephfs/cephfs-table-tool.cc: 11 in main()
> >
> > ** CID 1264458:  Uninitialized scalar field  (UNINIT_CTOR)
> > /test/librbd/test_ImageWatcher.cc: 47 in TestImageWatcher::WatchCtx::WatchCtx(TestImageWatcher&)()
> >
> > ** CID 1264459:  Uninitialized scalar field  (UNINIT_CTOR)
> > /test/librbd/test_fixture.cc: 44 in TestFixture::TestFixture()()
> >
> > ** CID 1264460:  Structurally dead code  (UNREACHABLE)
> > /common/sync_filesystem.h: 51 in sync_filesystem(int)()
> >
> >
> > ________________________________________________________________________________________________________
> > *** CID 1264457:  Uncaught exception  (UNCAUGHT_EXCEPT)
> > /tools/cephfs/cephfs-table-tool.cc: 11 in main()
> > 5     #include "common/errno.h"
> > 6     #include "global/global_init.h"
> > 7
> > 8     #include "TableTool.h"
> > 9
> > 10
> >>>>     CID 1264457:  Uncaught exception  (UNCAUGHT_EXCEPT)
> >>>>     In function "main(int, char const **)" an exception of type "ceph::FailedAssertion" is thrown and never caught.
> > 11     int main(int argc, const char **argv)
> > 12     {
> > 13       vector<const char*> args;
> > 14       argv_to_vec(argc, argv, args);
> > 15       env_to_vec(args);
> > 16
> > /tools/cephfs/cephfs-table-tool.cc: 11 in main()
> > 5     #include "common/errno.h"
> > 6     #include "global/global_init.h"
> > 7
> > 8     #include "TableTool.h"
> > 9
> > 10
> >>>>     CID 1264457:  Uncaught exception  (UNCAUGHT_EXCEPT)
> >>>>     In function "main(int, char const **)" an exception of type "ceph::FailedAssertion" is thrown and never caught.
> > 11     int main(int argc, const char **argv)
> > 12     {
> > 13       vector<const char*> args;
> > 14       argv_to_vec(argc, argv, args);
> > 15       env_to_vec(args);
> > 16
> > /tools/cephfs/cephfs-table-tool.cc: 11 in main()
> > 5     #include "common/errno.h"
> > 6     #include "global/global_init.h"
> > 7
> > 8     #include "TableTool.h"
> > 9
> > 10
> >>>>     CID 1264457:  Uncaught exception  (UNCAUGHT_EXCEPT)
> >>>>     In function "main(int, char const **)" an exception of type "ceph::FailedAssertion" is thrown and never caught.
> > 11     int main(int argc, const char **argv)
> > 12     {
> > 13       vector<const char*> args;
> > 14       argv_to_vec(argc, argv, args);
> > 15       env_to_vec(args);
> > 16
> > /tools/cephfs/cephfs-table-tool.cc: 11 in main()
> > 5     #include "common/errno.h"
> > 6     #include "global/global_init.h"
> > 7
> > 8     #include "TableTool.h"
> > 9
> > 10
> >>>>     CID 1264457:  Uncaught exception  (UNCAUGHT_EXCEPT)
> >>>>     In function "main(int, char const **)" an exception of type "ceph::FailedAssertion" is thrown and never caught.
> > 11     int main(int argc, const char **argv)
> > 12     {
> > 13       vector<const char*> args;
> > 14       argv_to_vec(argc, argv, args);
> > 15       env_to_vec(args);
> > 16
> > /tools/cephfs/cephfs-table-tool.cc: 11 in main()
> > 5     #include "common/errno.h"
> > 6     #include "global/global_init.h"
> > 7
> > 8     #include "TableTool.h"
> > 9
> > 10
> >>>>     CID 1264457:  Uncaught exception  (UNCAUGHT_EXCEPT)
> >>>>     In function "main(int, char const **)" an exception of type "ceph::FailedAssertion" is thrown and never caught.
> > 11     int main(int argc, const char **argv)
> > 12     {
> > 13       vector<const char*> args;
> > 14       argv_to_vec(argc, argv, args);
> > 15       env_to_vec(args);
> > 16
> >
> > ________________________________________________________________________________________________________
> > *** CID 1264458:  Uninitialized scalar field  (UNINIT_CTOR)
> > /test/librbd/test_ImageWatcher.cc: 47 in TestImageWatcher::WatchCtx::WatchCtx(TestImageWatcher&)()
> > 41         NOTIFY_OP_REQUEST_LOCK  = 2,
> > 42         NOTIFY_OP_HEADER_UPDATE = 3
> > 43       };
> > 44
> > 45       class WatchCtx : public librados::WatchCtx2 {
> > 46       public:
> >>>>     CID 1264458:  Uninitialized scalar field  (UNINIT_CTOR)
> >>>>     Non-static class member "m_handle" is not initialized in this constructor nor in any functions that it calls.
> > 47         WatchCtx(TestImageWatcher &parent) : m_parent(parent) {}
> > 48
> > 49         int watch(const librbd::ImageCtx &ictx) {
> > 50           m_header_oid = ictx.header_oid;
> > 51           return m_parent.m_ioctx.watch2(m_header_oid, &m_handle, this);
> > 52         }
> >
> > ________________________________________________________________________________________________________
> > *** CID 1264459:  Uninitialized scalar field  (UNINIT_CTOR)
> > /test/librbd/test_fixture.cc: 44 in TestFixture::TestFixture()()
> > 38
> > 39     std::string TestFixture::_pool_name;
> > 40     librados::Rados TestFixture::_rados;
> > 41     uint64_t TestFixture::_image_number = 0;
> > 42
> > 43     TestFixture::TestFixture() {
> >>>>     CID 1264459:  Uninitialized scalar field  (UNINIT_CTOR)
> >>>>     Non-static class member "m_image_size" is not initialized in this constructor nor in any functions that it calls.
> > 44     }
> > 45
> > 46     void TestFixture::SetUpTestCase() {
> > 47       _pool_name = get_temp_pool_name();
> > 48       ASSERT_EQ("", create_one_pool_pp(_pool_name, _rados));
> > 49     }
> >
> > ________________________________________________________________________________________________________
> > *** CID 1264460:  Structurally dead code  (UNREACHABLE)
> > /common/sync_filesystem.h: 51 in sync_filesystem(int)()
> > 45       if (syscall(__NR_syncfs, fd) == 0)
> > 46         return 0;
> > 47       else
> > 48         return -errno;
> > 49     #endif
> > 50
> >>>>     CID 1264460:  Structurally dead code  (UNREACHABLE)
> >>>>     This code cannot be reached: "sync();".
> > 51       sync();
> > 52       return 0;
> > 53     }
> > 54
> >
> >
> > ________________________________________________________________________________________________________
> > To view the defects in Coverity Scan visit, http://scan.coverity.com/projects/25?tab=overview
> >
> > To manage Coverity Scan email notifications for "ceph-devel@vger.kernel.org", click http://scan.coverity.com/subscriptions/edit?email=ceph-devel%40vger.kernel.org&token=018084d671e3cc89d00dd2ccb7eb849c .
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 

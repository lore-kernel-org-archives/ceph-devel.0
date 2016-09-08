From: Somnath Roy <Somnath.Roy@sandisk.com>
Subject: RE: no more autotools
Date: Thu, 8 Sep 2016 14:58:31 +0000
Message-ID: <BL2PR02MB2115460AF429AF9002962CA8F4FB0@BL2PR02MB2115.namprd02.prod.outlook.com>
References: <alpine.DEB.2.11.1609081352170.9549@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-dm3nam03on0060.outbound.protection.outlook.com ([104.47.41.60]:64144
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965929AbcIHO6i (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 8 Sep 2016 10:58:38 -0400
In-Reply-To: <alpine.DEB.2.11.1609081352170.9549@piezo.us.to>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Cc: "adeza@redhat.com" <adeza@redhat.com>, "abhishek@suse.com" <abhishek@suse.com>

Sage,
I saw do_autogen.sh is still there but failing as autogen.sh not there :-).=
.
One more thing , jemalloc enabled build along with rocksdb is still failing=
 , I had to manually uncomment the following in db_impl.cc to get it throug=
h.

/*static void GetJemallocStatus(void* mstat_arg, const char* status) {
  MallocStatus* mstat =3D reinterpret_cast<MallocStatus*>(mstat_arg);
  size_t status_len =3D status ? strlen(status) : 0;
  size_t buf_size =3D (size_t)(mstat->end - mstat->cur);
  if (!status_len || status_len > buf_size) {
    return;
  }

  snprintf(mstat->cur, buf_size, "%s", status);
  mstat->cur +=3D status_len;
}*/


//malloc_stats_print(GetJemallocStatus, &mstat, "");

I did this to enable jemalloc with cmake.

./install-deps.sh
./do_cmake.sh
cd build
cmake -D ALLOCATOR=3Djemalloc ..
make -j48

Thanks & Regards
Somnath

-----Original Message-----
From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.kernel=
.org] On Behalf Of Sage Weil
Sent: Thursday, September 08, 2016 7:00 AM
To: ceph-devel@vger.kernel.org
Cc: adeza@redhat.com; abhishek@suse.com
Subject: no more autotools

Yesterday we merged a PR that removed all of the autotools build infrastruc=
ture from the master branch of ceph.git.  We'll be 100% cmake for Kraken.  =
Hooray!

Huge thank you to Ali, Casey, Kefu, and everyone else who helped with this =
effort!

The gitbuilder and teuthology bits should all now be fully functional with =
cmake-only as we've been doing builds and tests with it for a while.
We've no doubt broken some things with the release builds.

I think the next step should be to do a dev release (11.0.1) to work throug=
h the kinks and ensure that in a few weeks/months time when we are ready fo=
r kraken -rc's everything is working.  Alfredo and Abhishek, this will be m=
ostly fall on you :).  I think any master commit is fine for our purposes (=
it's just a dev checkpoint and the main goal is to make sure the build work=
s, not produce a well-tested set of packages for end users).

sage
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
PLEASE NOTE: The information contained in this electronic mail message is i=
ntended only for the use of the designated recipient(s) named above. If the=
 reader of this message is not the intended recipient, you are hereby notif=
ied that you have received this message in error and that any review, disse=
mination, distribution, or copying of this message is strictly prohibited. =
If you have received this communication in error, please notify the sender =
by telephone or e-mail (as shown above) immediately and destroy any and all=
 copies of this message in your possession (whether hard copies or electron=
ically stored copies).

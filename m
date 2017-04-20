From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH 0/2] fs, ceph filesystem refcount conversions
Date: Thu, 20 Apr 2017 11:40:37 +0200
Message-ID: <CAOi1vP-cVj19gU4yi8z0wssokT8oTM1n-cKRURDdL0t2ztxJ6w@mail.gmail.com>
References: <1488532507-27863-1-git-send-email-elena.reshetova@intel.com>
 <CAOi1vP-wZL9yW=_MkhU0x6fGn=9=xEYP1T03ikL2p6g49Vandw@mail.gmail.com> <2236FBA76BA1254E88B949DDB74E612B41C8D6E8@IRSMSX102.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2236FBA76BA1254E88B949DDB74E612B41C8D6E8@IRSMSX102.ger.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Reshetova, Elena" <elena.reshetova@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ceph Development <ceph-devel@vger.kernel.org>, "peterz@infradead.org" <peterz@infradead.org>, Greg KH <gregkh@linuxfoundation.org>, "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>
List-Id: ceph-devel.vger.kernel.org

On Thu, Apr 20, 2017 at 9:40 AM, Reshetova, Elena
<elena.reshetova@intel.com> wrote:
>
>> On Fri, Mar 3, 2017 at 10:15 AM, Elena Reshetova
>> <elena.reshetova@intel.com> wrote:
>> > Now when new refcount_t type and API are finally merged
>> > (see include/linux/refcount.h), the following
>> > patches convert various refcounters in the ceph filesystem from atomic_t
>> > to refcount_t. By doing this we prevent intentional or accidental
>> > underflows or overflows that can led to use-after-free vulnerabilities.
>> >
>> > The below patches are fully independent and can be cherry-picked separately.
>> > Since we convert all kernel subsystems in the same fashion, resulting
>> > in about 300 patches, we have to group them for sending at least in some
>> > fashion to be manageable. Please excuse the long cc list.
>> >
>> > Not runtime tested, since I am not sure how to do it for ceph.
>> > However changes are pretty trivial in this case.
>> >
>> > Elena Reshetova (2):
>> >   fs, ceph: convert ceph_mds_session.s_ref from atomic_t to refcount_t
>> >   fs, ceph: convert ceph_cap_snap.nref from atomic_t to refcount_t
>> >
>> >  fs/ceph/caps.c       |  4 ++--
>> >  fs/ceph/mds_client.c | 18 +++++++++---------
>> >  fs/ceph/mds_client.h |  5 +++--
>> >  fs/ceph/snap.c       |  2 +-
>> >  fs/ceph/super.h      |  5 +++--
>> >  5 files changed, 18 insertions(+), 16 deletions(-)
>>
>> I'll pull these into testing.
>
> Just a check: how did testing went on this?
> If everything is good, can you merge the changes?

Yep, I'll merge these into 4.12.

Thanks,

                Ilya

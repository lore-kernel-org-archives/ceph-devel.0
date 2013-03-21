From: Gregory Farnum <greg@inktank.com>
Subject: Re: [PATCH 13/39] mds: don't send resolve message between active MDS
Date: Thu, 21 Mar 2013 14:55:52 -0700
Message-ID: <CAPYLRzgccRd=GaBR9-y0JVCGU2rcZoTNQtNTMEM0a9iXPYSWRw@mail.gmail.com>
References: <1363531902-24909-1-git-send-email-zheng.z.yan@intel.com>
	<1363531902-24909-14-git-send-email-zheng.z.yan@intel.com>
	<CAPYLRzj0BYniL2g21qhFFV0OvhZU-O+btnTFAfsj7=qPR-b_mw@mail.gmail.com>
	<514A76AD.5030005@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f179.google.com ([209.85.216.179]:47057 "EHLO
	mail-qc0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753813Ab3CUVzx convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 Mar 2013 17:55:53 -0400
Received: by mail-qc0-f179.google.com with SMTP id b40so1651890qcq.38
        for <ceph-devel@vger.kernel.org>; Thu, 21 Mar 2013 14:55:52 -0700 (PDT)
In-Reply-To: <514A76AD.5030005@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zheng.z.yan@intel.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Sage Weil <sage@inktank.com>

On Wed, Mar 20, 2013 at 7:55 PM, Yan, Zheng <zheng.z.yan@intel.com> wro=
te:
> On 03/21/2013 05:56 AM, Gregory Farnum wrote:
>> On Sun, Mar 17, 2013 at 7:51 AM, Yan, Zheng <zheng.z.yan@intel.com> =
wrote:
>>> From: "Yan, Zheng" <zheng.z.yan@intel.com>
>>>
>>> When MDS cluster is resolving, current behavior is sending subtree =
resolve
>>> message to all other MDS and waiting for all other MDS' resolve mes=
sage.
>>> The problem is that active MDS can have diffent subtree map due to =
rename.
>>> Besides gathering active MDS's resolve messages are also racy. The =
only
>>> function for these messages is disambiguate other MDS' import. We c=
an
>>> replace it by import finish notification.
>>>
>>> Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
>>> ---
>>>  src/mds/MDCache.cc  | 12 +++++++++---
>>>  src/mds/Migrator.cc | 25 +++++++++++++++++++++++--
>>>  src/mds/Migrator.h  |  3 ++-
>>>  3 files changed, 34 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/src/mds/MDCache.cc b/src/mds/MDCache.cc
>>> index c455a20..73c1d59 100644
>>> --- a/src/mds/MDCache.cc
>>> +++ b/src/mds/MDCache.cc
>>> @@ -2517,7 +2517,8 @@ void MDCache::send_subtree_resolves()
>>>         ++p) {
>>>      if (*p =3D=3D mds->whoami)
>>>        continue;
>>> -    resolves[*p] =3D new MMDSResolve;
>>> +    if (mds->is_resolve() || mds->mdsmap->is_resolve(*p))
>>> +      resolves[*p] =3D new MMDSResolve;
>>>    }
>>>
>>>    // known
>>> @@ -2837,7 +2838,7 @@ void MDCache::handle_resolve(MMDSResolve *m)
>>>           migrator->import_reverse(dir);
>>>         } else {
>>>           dout(7) << "ambiguous import succeeded on " << *dir << de=
ndl;
>>> -         migrator->import_finish(dir);
>>> +         migrator->import_finish(dir, true);
>>>         }
>>>         my_ambiguous_imports.erase(p);  // no longer ambiguous.
>>>        }
>>> @@ -3432,7 +3433,12 @@ void MDCache::rejoin_send_rejoins()
>>>         ++p) {
>>>      CDir *dir =3D p->first;
>>>      assert(dir->is_subtree_root());
>>> -    assert(!dir->is_ambiguous_dir_auth());
>>> +    if (dir->is_ambiguous_dir_auth()) {
>>> +      // exporter is recovering, importer is survivor.
>>
>> The importer has to be the MDS this code is running on, right?
>
> This code is for bystanders. The exporter is recovering, and its reso=
lve message didn't claim
> the subtree. So the export must succeed.

Ah, yep. That's what I get for eyeing just the diff.

>
>>
>>> +      assert(rejoins.count(dir->authority().first));
>>> +      assert(!rejoins.count(dir->authority().second));
>>> +      continue;
>>> +    }
>>>
>>>      // my subtree?
>>>      if (dir->is_auth())
>>> diff --git a/src/mds/Migrator.cc b/src/mds/Migrator.cc
>>> index 5e53803..833df12 100644
>>> --- a/src/mds/Migrator.cc
>>> +++ b/src/mds/Migrator.cc
>>> @@ -2088,6 +2088,23 @@ void Migrator::import_reverse(CDir *dir)
>>>    }
>>>  }
>>>
>>> +void Migrator::import_notify_finish(CDir *dir, set<CDir*>& bounds)
>>> +{
>>> +  dout(7) << "import_notify_finish " << *dir << dendl;
>>> +
>>> +  for (set<int>::iterator p =3D import_bystanders[dir].begin();
>>> +       p !=3D import_bystanders[dir].end();
>>> +       ++p) {
>>> +    MExportDirNotify *notify =3D
>>> +      new MExportDirNotify(dir->dirfrag(), false,
>>> +                          pair<int,int>(import_peer[dir->dirfrag()=
], mds->get_nodeid()),
>>> +                          pair<int,int>(mds->get_nodeid(), CDIR_AU=
TH_UNKNOWN));
>>
>> I don't think this is quite right =97 we're notifying them that we'v=
e
>> just finished importing data from somebody, right? And so we know th=
at
>> we're the auth node...
>
> Yes. In normal case, exporter notifies the bystanders. But if exporte=
r crashes, the importer notifies
> the bystanders after it confirms ambiguous import succeeds.

Never mind =97 I had the semantic meaning of these pairs wrong.

Reviewed-by: Greg Farnum <greg@inktank.com>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

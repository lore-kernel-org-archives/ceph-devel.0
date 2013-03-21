From: Gregory Farnum <greg@inktank.com>
Subject: Re: [PATCH 08/39] mds: consider MDS as recovered when it reaches
 clientreply state.
Date: Thu, 21 Mar 2013 14:43:21 -0700
Message-ID: <CAPYLRzi7Zuo9ME1tzRzMG-YanZvG+f-SfEpE=W8OeDyYtHZY1g@mail.gmail.com>
References: <1363531902-24909-1-git-send-email-zheng.z.yan@intel.com>
	<1363531902-24909-9-git-send-email-zheng.z.yan@intel.com>
	<80DEECF59AAD445C8EEEFCE71A74EA78@inktank.com>
	<514A6EFE.3000009@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qe0-f51.google.com ([209.85.128.51]:48512 "EHLO
	mail-qe0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751986Ab3CUVnX convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 Mar 2013 17:43:23 -0400
Received: by mail-qe0-f51.google.com with SMTP id nd7so2113738qeb.38
        for <ceph-devel@vger.kernel.org>; Thu, 21 Mar 2013 14:43:22 -0700 (PDT)
In-Reply-To: <514A6EFE.3000009@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zheng.z.yan@intel.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Sage Weil <sage@inktank.com>

On Wed, Mar 20, 2013 at 7:22 PM, Yan, Zheng <zheng.z.yan@intel.com> wro=
te:
> On 03/21/2013 02:40 AM, Greg Farnum wrote:
>> The idea of this patch makes sense, but I'm not sure if we guarantee=
 that each daemon sees every map update =97 if they don't then if an MD=
S misses the map moving an MDS into CLIENTREPLAY then they won't proces=
s them as having recovered on the next map. Sage or Joao, what are the =
guarantees subscription provides?
>> -Greg
>
> See MDS::active_start(), it also kicks clientreplay waiters. And I wi=
ll fix the 'clientreply' typo in my git tree.

That's for the recovering MDS =97 I was referring to observers who are
watching it come up. However, I've just checked and the monitor does
guarantee every-map delivery, so this isn't a problem.

Reviewed-by: Greg Farnum <greg@inktank.com>

>
> Thanks
> Yan, Zheng
>
>>
>> Software Engineer #42 @ http://inktank.com | http://ceph.com
>>
>>
>> On Sunday, March 17, 2013 at 7:51 AM, Yan, Zheng wrote:
>>
>>> From: "Yan, Zheng" <zheng.z.yan@intel.com (mailto:zheng.z.yan@intel=
=2Ecom)>
>>>
>>> MDS in clientreply state already start servering requests. It also
>>> make MDS::handle_mds_recovery() and MDS::recovery_done() match.
>>>
>>> Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com (mailto:zheng.z.ya=
n@intel.com)>
>>> ---
>>> src/mds/MDS.cc (http://MDS.cc) | 2 ++
>>> 1 file changed, 2 insertions(+)
>>>
>>> diff --git a/src/mds/MDS.cc (http://MDS.cc) b/src/mds/MDS.cc (http:=
//MDS.cc)
>>> index 282fa64..b91dcbd 100644
>>> --- a/src/mds/MDS.cc (http://MDS.cc)
>>> +++ b/src/mds/MDS.cc (http://MDS.cc)
>>> @@ -1032,7 +1032,9 @@ void MDS::handle_mds_map(MMDSMap *m)
>>>
>>> set<int> oldactive, active;
>>> oldmap->get_mds_set(oldactive, MDSMap::STATE_ACTIVE);
>>> + oldmap->get_mds_set(oldactive, MDSMap::STATE_CLIENTREPLAY);
>>> mdsmap->get_mds_set(active, MDSMap::STATE_ACTIVE);
>>> + mdsmap->get_mds_set(active, MDSMap::STATE_CLIENTREPLAY);
>>> for (set<int>::iterator p =3D active.begin(); p !=3D active.end(); =
++p)
>>> if (*p !=3D whoami && // not me
>>> oldactive.count(*p) =3D=3D 0) // newly so?
>>> --
>>> 1.7.11.7
>>
>>
>>
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

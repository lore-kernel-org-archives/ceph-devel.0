From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: Re: [PATCH 08/39] mds: consider MDS as recovered when it reaches
 clientreply state.
Date: Thu, 21 Mar 2013 10:22:54 +0800
Message-ID: <514A6EFE.3000009@intel.com>
References: <1363531902-24909-1-git-send-email-zheng.z.yan@intel.com> <1363531902-24909-9-git-send-email-zheng.z.yan@intel.com> <80DEECF59AAD445C8EEEFCE71A74EA78@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:13088 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752844Ab3CUCW4 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 20 Mar 2013 22:22:56 -0400
In-Reply-To: <80DEECF59AAD445C8EEEFCE71A74EA78@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Greg Farnum <greg@inktank.com>
Cc: ceph-devel@vger.kernel.org, sage@inktank.com

On 03/21/2013 02:40 AM, Greg Farnum wrote:
> The idea of this patch makes sense, but I'm not sure if we guarantee =
that each daemon sees every map update =E2=80=94 if they don't then if =
an MDS misses the map moving an MDS into CLIENTREPLAY then they won't p=
rocess them as having recovered on the next map. Sage or Joao, what are=
 the guarantees subscription provides? =20
> -Greg

See MDS::active_start(), it also kicks clientreplay waiters. And I will=
 fix the 'clientreply' typo in my git tree.

Thanks
Yan, Zheng

>=20
> Software Engineer #42 @ http://inktank.com | http://ceph.com
>=20
>=20
> On Sunday, March 17, 2013 at 7:51 AM, Yan, Zheng wrote:
>=20
>> From: "Yan, Zheng" <zheng.z.yan@intel.com (mailto:zheng.z.yan@intel.=
com)>
>> =20
>> MDS in clientreply state already start servering requests. It also
>> make MDS::handle_mds_recovery() and MDS::recovery_done() match.
>> =20
>> Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com (mailto:zheng.z.yan=
@intel.com)>
>> ---
>> src/mds/MDS.cc (http://MDS.cc) | 2 ++
>> 1 file changed, 2 insertions(+)
>> =20
>> diff --git a/src/mds/MDS.cc (http://MDS.cc) b/src/mds/MDS.cc (http:/=
/MDS.cc)
>> index 282fa64..b91dcbd 100644
>> --- a/src/mds/MDS.cc (http://MDS.cc)
>> +++ b/src/mds/MDS.cc (http://MDS.cc)
>> @@ -1032,7 +1032,9 @@ void MDS::handle_mds_map(MMDSMap *m)
>> =20
>> set<int> oldactive, active;
>> oldmap->get_mds_set(oldactive, MDSMap::STATE_ACTIVE);
>> + oldmap->get_mds_set(oldactive, MDSMap::STATE_CLIENTREPLAY);
>> mdsmap->get_mds_set(active, MDSMap::STATE_ACTIVE);
>> + mdsmap->get_mds_set(active, MDSMap::STATE_CLIENTREPLAY);
>> for (set<int>::iterator p =3D active.begin(); p !=3D active.end(); +=
+p) =20
>> if (*p !=3D whoami && // not me
>> oldactive.count(*p) =3D=3D 0) // newly so?
>> -- =20
>> 1.7.11.7
>=20
>=20
>=20

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: Re: [PATCH 04/39] mds: make sure table request id unique
Date: Wed, 20 Mar 2013 13:53:58 +0800
Message-ID: <51494EF6.6040607@intel.com>
References: <1363531902-24909-1-git-send-email-zheng.z.yan@intel.com> <1363531902-24909-5-git-send-email-zheng.z.yan@intel.com> <C7E493EEAA91442B9BD120B881E4638F@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:40766 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755297Ab3CTFyA (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 20 Mar 2013 01:54:00 -0400
In-Reply-To: <C7E493EEAA91442B9BD120B881E4638F@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Greg Farnum <greg@inktank.com>
Cc: ceph-devel@vger.kernel.org, sage@inktank.com

On 03/20/2013 07:09 AM, Greg Farnum wrote:
> Hmm, this is definitely narrowing the race (probably enough to never =
hit it), but it's not actually eliminating it (if the restart happens a=
fter 4 billion requests=E2=80=A6). More importantly this kind of sympto=
m makes me worry that we might be papering over more serious issues wit=
h colliding states in the Table on restart.
> I don't have the MDSTable semantics in my head so I'll need to look i=
nto this later unless somebody else volunteers to do so=E2=80=A6

Not just 4 billion requests, MDS restart has several stage, mdsmap epoc=
h increases for each stage. I don't think there are any more colliding =
states in the table. The table client/server use two phase commit. it's=
 similar to client request that involves multiple MDS. the reqid is ana=
logy to client request id. The difference is client request ID is uniqu=
e because new client always get an unique session id.

Thanks
Yan, Zheng

> -Greg
>=20
> Software Engineer #42 @ http://inktank.com | http://ceph.com
>=20
>=20
> On Sunday, March 17, 2013 at 7:51 AM, Yan, Zheng wrote:
>=20
>> From: "Yan, Zheng" <zheng.z.yan@intel.com>
>> =20
>> When a MDS becomes active, the table server re-sends 'agree' message=
s
>> for old prepared request. If the recoverd MDS starts a new table req=
uest
>> at the same time, The new request's ID can happen to be the same as =
old
>> prepared request's ID, because current table client assigns request =
ID
>> from zero after MDS restarts.
>> =20
>> Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com (mailto:zheng.z.yan=
@intel.com)>
>> ---
>> src/mds/MDS.cc (http://MDS.cc) | 3 +++
>> src/mds/MDSTableClient.cc (http://MDSTableClient.cc) | 5 +++++
>> src/mds/MDSTableClient.h | 2 ++
>> 3 files changed, 10 insertions(+)
>> =20
>> diff --git a/src/mds/MDS.cc (http://MDS.cc) b/src/mds/MDS.cc (http:/=
/MDS.cc)
>> index bb1c833..859782a 100644
>> --- a/src/mds/MDS.cc (http://MDS.cc)
>> +++ b/src/mds/MDS.cc (http://MDS.cc)
>> @@ -1212,6 +1212,9 @@ void MDS::boot_start(int step, int r)
>> dout(2) << "boot_start " << step << ": opening snap table" << dendl;=
 =20
>> snapserver->load(gather.new_sub());
>> }
>> +
>> + anchorclient->init();
>> + snapclient->init();
>> =20
>> dout(2) << "boot_start " << step << ": opening mds log" << dendl;
>> mdlog->open(gather.new_sub());
>> diff --git a/src/mds/MDSTableClient.cc (http://MDSTableClient.cc) b/=
src/mds/MDSTableClient.cc (http://MDSTableClient.cc)
>> index ea021f5..beba0a3 100644
>> --- a/src/mds/MDSTableClient.cc (http://MDSTableClient.cc)
>> +++ b/src/mds/MDSTableClient.cc (http://MDSTableClient.cc)
>> @@ -34,6 +34,11 @@
>> #undef dout_prefix
>> #define dout_prefix *_dout << "mds." << mds->get_nodeid() << ".table=
client(" << get_mdstable_name(table) << ") "
>> =20
>> +void MDSTableClient::init()
>> +{
>> + // make reqid unique between MDS restarts
>> + last_reqid =3D (uint64_t)mds->mdsmap->get_epoch() << 32;
>> +}
>> =20
>> void MDSTableClient::handle_request(class MMDSTableRequest *m)
>> {
>> diff --git a/src/mds/MDSTableClient.h b/src/mds/MDSTableClient.h
>> index e15837f..78035db 100644
>> --- a/src/mds/MDSTableClient.h
>> +++ b/src/mds/MDSTableClient.h
>> @@ -63,6 +63,8 @@ public:
>> MDSTableClient(MDS *m, int tab) : mds(m), table(tab), last_reqid(0) =
{}
>> virtual ~MDSTableClient() {}
>> =20
>> + void init();
>> +
>> void handle_request(MMDSTableRequest *m);
>> =20
>> void _prepare(bufferlist& mutation, version_t *ptid, bufferlist *pbl=
, Context *onfinish);
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

From: Greg Farnum <greg@inktank.com>
Subject: Re: [PATCH 04/39] mds: make sure table request id unique
Date: Tue, 19 Mar 2013 16:09:38 -0700
Message-ID: <C7E493EEAA91442B9BD120B881E4638F@inktank.com>
References: <1363531902-24909-1-git-send-email-zheng.z.yan@intel.com>
 <1363531902-24909-5-git-send-email-zheng.z.yan@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f48.google.com ([209.85.160.48]:44345 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754733Ab3CSXJm convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 19 Mar 2013 19:09:42 -0400
Received: by mail-pb0-f48.google.com with SMTP id wy12so817193pbc.21
        for <ceph-devel@vger.kernel.org>; Tue, 19 Mar 2013 16:09:41 -0700 (PDT)
In-Reply-To: <1363531902-24909-5-git-send-email-zheng.z.yan@intel.com>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?utf-8?Q?Yan=2C_Zheng?= <zheng.z.yan@intel.com>
Cc: ceph-devel@vger.kernel.org, sage@inktank.com

Hmm, this is definitely narrowing the race (probably enough to never hi=
t it), but it's not actually eliminating it (if the restart happens aft=
er 4 billion requests=E2=80=A6). More importantly this kind of symptom =
makes me worry that we might be papering over more serious issues with =
colliding states in the Table on restart.
I don't have the MDSTable semantics in my head so I'll need to look int=
o this later unless somebody else volunteers to do so=E2=80=A6
-Greg

Software Engineer #42 @ http://inktank.com | http://ceph.com


On Sunday, March 17, 2013 at 7:51 AM, Yan, Zheng wrote:

> From: "Yan, Zheng" <zheng.z.yan@intel.com>
> =20
> When a MDS becomes active, the table server re-sends 'agree' messages
> for old prepared request. If the recoverd MDS starts a new table requ=
est
> at the same time, The new request's ID can happen to be the same as o=
ld
> prepared request's ID, because current table client assigns request I=
D
> from zero after MDS restarts.
> =20
> Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com (mailto:zheng.z.yan@=
intel.com)>
> ---
> src/mds/MDS.cc (http://MDS.cc) | 3 +++
> src/mds/MDSTableClient.cc (http://MDSTableClient.cc) | 5 +++++
> src/mds/MDSTableClient.h | 2 ++
> 3 files changed, 10 insertions(+)
> =20
> diff --git a/src/mds/MDS.cc (http://MDS.cc) b/src/mds/MDS.cc (http://=
MDS.cc)
> index bb1c833..859782a 100644
> --- a/src/mds/MDS.cc (http://MDS.cc)
> +++ b/src/mds/MDS.cc (http://MDS.cc)
> @@ -1212,6 +1212,9 @@ void MDS::boot_start(int step, int r)
> dout(2) << "boot_start " << step << ": opening snap table" << dendl; =
=20
> snapserver->load(gather.new_sub());
> }
> +
> + anchorclient->init();
> + snapclient->init();
> =20
> dout(2) << "boot_start " << step << ": opening mds log" << dendl;
> mdlog->open(gather.new_sub());
> diff --git a/src/mds/MDSTableClient.cc (http://MDSTableClient.cc) b/s=
rc/mds/MDSTableClient.cc (http://MDSTableClient.cc)
> index ea021f5..beba0a3 100644
> --- a/src/mds/MDSTableClient.cc (http://MDSTableClient.cc)
> +++ b/src/mds/MDSTableClient.cc (http://MDSTableClient.cc)
> @@ -34,6 +34,11 @@
> #undef dout_prefix
> #define dout_prefix *_dout << "mds." << mds->get_nodeid() << ".tablec=
lient(" << get_mdstable_name(table) << ") "
> =20
> +void MDSTableClient::init()
> +{
> + // make reqid unique between MDS restarts
> + last_reqid =3D (uint64_t)mds->mdsmap->get_epoch() << 32;
> +}
> =20
> void MDSTableClient::handle_request(class MMDSTableRequest *m)
> {
> diff --git a/src/mds/MDSTableClient.h b/src/mds/MDSTableClient.h
> index e15837f..78035db 100644
> --- a/src/mds/MDSTableClient.h
> +++ b/src/mds/MDSTableClient.h
> @@ -63,6 +63,8 @@ public:
> MDSTableClient(MDS *m, int tab) : mds(m), table(tab), last_reqid(0) {=
}
> virtual ~MDSTableClient() {}
> =20
> + void init();
> +
> void handle_request(MMDSTableRequest *m);
> =20
> void _prepare(bufferlist& mutation, version_t *ptid, bufferlist *pbl,=
 Context *onfinish);
> -- =20
> 1.7.11.7



--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

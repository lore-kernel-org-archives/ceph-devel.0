From: Big Chiu <big.chiu@bigtera.com>
Subject: Re: [PATCH] mds: fix setting/removing xattrs on root
Date: Thu, 18 Apr 2013 15:16:39 +0800
Message-ID: <CAAst5YOFEOjCFfXBA3xbe7wUkCmvKr+vwefv2vExEvuSxhG2Wg@mail.gmail.com>
References: <1366021404-5812-1-git-send-email-big.chiu@bigtera.com>
	<1366021404-5812-2-git-send-email-big.chiu@bigtera.com>
	<CAPYLRzgK5siEsvd-Uj8-4SxrUSLAz0j4S45TCb3ZCCzTkeFfFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qe0-f43.google.com ([209.85.128.43]:61111 "EHLO
	mail-qe0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755550Ab3DRHQk convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 18 Apr 2013 03:16:40 -0400
Received: by mail-qe0-f43.google.com with SMTP id f6so1456564qej.30
        for <ceph-devel@vger.kernel.org>; Thu, 18 Apr 2013 00:16:39 -0700 (PDT)
In-Reply-To: <CAPYLRzgK5siEsvd-Uj8-4SxrUSLAz0j4S45TCb3ZCCzTkeFfFA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Henry Chang <henry@bigtera.com>

I didn't notice the bug. Guessing it was hidden because CephFS had been
accessed by other daemons in my test environment. Thank you for the hin=
t!

The signed-off patches are resent, also including your fix.

On Wed, Apr 17, 2013 at 4:06 AM, Gregory Farnum <greg@inktank.com> wrot=
e:
> On Mon, Apr 15, 2013 at 3:23 AM, Kuan Kai Chiu <big.chiu@bigtera.com>=
 wrote:
>> MDS crashes while journaling dirty root inode in handle_client_setxa=
ttr
>> and handle_client_removexattr. We should use journal_dirty_inode to
>> safely log root inode here.
>> ---
>>  src/mds/Server.cc |    6 ++----
>>  1 file changed, 2 insertions(+), 4 deletions(-)
>>
>> diff --git a/src/mds/Server.cc b/src/mds/Server.cc
>> index 11ab834..1e62dd2 100644
>> --- a/src/mds/Server.cc
>> +++ b/src/mds/Server.cc
>> @@ -3907,8 +3907,7 @@ void Server::handle_client_setxattr(MDRequest =
*mdr)
>>    mdlog->start_entry(le);
>>    le->metablob.add_client_req(req->get_reqid(), req->get_oldest_cli=
ent_tid());
>>    mdcache->predirty_journal_parents(mdr, &le->metablob, cur, 0, PRE=
DIRTY_PRIMARY, false);
>> -  mdcache->journal_cow_inode(mdr, &le->metablob, cur);
>> -  le->metablob.add_primary_dentry(cur->get_projected_parent_dn(), t=
rue, cur);
>> +  mdcache->journal_dirty_inode(mdr, &le->metablob, cur);
>>
>>    journal_and_reply(mdr, cur, 0, le, new C_MDS_inode_update_finish(=
mds, mdr, cur));
>>  }
>> @@ -3964,8 +3963,7 @@ void Server::handle_client_removexattr(MDReque=
st *mdr)
>>    mdlog->start_entry(le);
>>    le->metablob.add_client_req(req->get_reqid(), req->get_oldest_cli=
ent_tid());
>>    mdcache->predirty_journal_parents(mdr, &le->metablob, cur, 0, PRE=
DIRTY_PRIMARY, false);
>> -  mdcache->journal_cow_inode(mdr, &le->metablob, cur);
>> -  le->metablob.add_primary_dentry(cur->get_projected_parent_dn(), t=
rue, cur);
>> +  mdcache->journal_dirty_inode(mdr, &le->metablob, cur);
>>
>>    journal_and_reply(mdr, cur, 0, le, new C_MDS_inode_update_finish(=
mds, mdr, cur));
>>  }
>
> This is fine as far as it goes, but we'll need your sign-off for us t=
o
> incorporate it into the codebase. Also, have you run any tests with
> it? The reason I ask is that when I apply this patch, set an xattr on
> the root inode, and then restart the MDS and client, there are no
> xattrs on the root any more. I think this should fix that, but there
> may be other such issues:
> diff --git a/src/mds/events/EMetaBlob.h b/src/mds/events/EMetaBlob.h
> index 7065460..439bd78 100644
> --- a/src/mds/events/EMetaBlob.h
> +++ b/src/mds/events/EMetaBlob.h
> @@ -468,7 +468,7 @@ private:
>
>      if (!pi) pi =3D in->get_projected_inode();
>      if (!pdft) pdft =3D &in->dirfragtree;
> -    if (!px) px =3D &in->xattrs;
> +    if (!px) px =3D in->get_projected_xattrs();
>
>      bufferlist snapbl;
>      if (psnapbl)
>
> You've fallen victim to this new setup, incidentally =97 in the past =
the
> root inode wasn't allowed to get any of these modifications because
> it's not quite real in the way the rest of them are. We opened that u=
p
> when we made the virtual xattr interface, but we weren't very careful
> about it so apparently we missed some side effects.
> -Greg
> Software Engineer #42 @ http://inktank.com | http://ceph.com
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

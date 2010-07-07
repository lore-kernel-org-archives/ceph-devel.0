From: Sage Weil <sage@newdream.net>
Subject: Re: doubt: inode_t->get_layout_size_increment() is signed.
Date: Tue, 6 Jul 2010 19:41:30 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1007061940170.8676@cobra.newdream.net>
References: <AANLkTingtd5NZClFkNsiuzX3phcFTzCeLw4-MiBt_wA9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-347314221-1278470490=:8676"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:45424 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752907Ab0GGCjw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 6 Jul 2010 22:39:52 -0400
In-Reply-To: <AANLkTingtd5NZClFkNsiuzX3phcFTzCeLw4-MiBt_wA9@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Miguel F Mascarenhas Sousa Filipe <miguel.filipe@gmail.com>
Cc: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-347314221-1278470490=:8676
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 6 Jul 2010, Miguel F Mascarenhas Sousa Filipe wrote:
> Hi there,
>=20
> I'm interested in this project and started now checking out the code
> and make it compile...
>=20
> I got hunting this signed comparison warning:
>=20
> mds/Locker.cc: In member function =FF=FFbool
> Locker::_do_cap_update(CInode*, Capability*, int, snapid_t,
> MClientCaps*, MClientCaps*)=FF=FF:
> mds/Locker.cc:1923: warning: comparison between signed and unsigned
> integer expressions
>=20
> that is related with inode_t->get_layout_size_increment() being signed.
> This seems like a bug since it returns a size, but since I don't know
> the implications of changing this to uint64_t.. I'm asking..
>=20
> Is this the right fix?

It is, and has already been fixed in the unstable branch (for v0.21). =20
You're probably looking at the master branch or a earlier release=20
tarball..

Thanks!
sage

> --------
>=20
>=20
> diff --git a/src/mds/mdstypes.h b/src/mds/mdstypes.h
> index b7bfd1d..3054610 100644
> --- a/src/mds/mdstypes.h
> +++ b/src/mds/mdstypes.h
> @@ -379,7 +379,7 @@ struct inode_t {
>=20
>    bool is_truncating() const { return (truncate_pending > 0); }
>=20
> -  int64_t get_layout_size_increment() {
> +  uint64_t get_layout_size_increment() {
>      return layout.fl_object_size * layout.fl_stripe_count;
>    }
>=20
> ------
>=20
> Kind regards,
>=20
> --=20
> Miguel Mascarenhas Filipe
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20
--557981400-347314221-1278470490=:8676--

From: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Subject: Re: Make libcephfs return error when unmounted?
Date: Wed, 11 Apr 2012 11:22:58 -0700
Message-ID: <CAC-hyiGhR-ayeffsT6ZTAS4aozr_Ub_YJQN8L5Hs9zM3zWBS5g@mail.gmail.com>
References: <71CC6D8F-361D-4C00-AED1-C0C928CDAB9F@cs.ucsc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:44711 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932510Ab2DKSXA convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 11 Apr 2012 14:23:00 -0400
Received: by bkcik5 with SMTP id ik5so915431bkc.19
        for <ceph-devel@vger.kernel.org>; Wed, 11 Apr 2012 11:22:59 -0700 (PDT)
In-Reply-To: <71CC6D8F-361D-4C00-AED1-C0C928CDAB9F@cs.ucsc.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <jayhawk@cs.ucsc.edu>
Cc: ceph-devel@vger.kernel.org, Greg Farnum <gregory.farnum@dreamhost.com>, Sage Weil <sage@newdream.net>

On Wed, Apr 11, 2012 at 11:12 AM, Noah Watkins <jayhawk@cs.ucsc.edu> wr=
ote:
>
> Hi all,
>
> A simple program like this:
>
> int main(int argc, char **argv)
> {
> =A0 =A0 =A0 =A0int ret;
> =A0 =A0 =A0 =A0struct ceph_mount_info *cmount;
>
> =A0 =A0 =A0 =A0ceph_create(&cmount, NULL);
> =A0 =A0 =A0 =A0//ceph_mount(cmount, NULL);
> =A0 =A0 =A0 =A0ceph_chdir(cmount, "/");
> }
>
> will segfault because in the below snippet, cmount->get_client() retu=
rns
> NULL when ceph_mount(..) has not been been called with success.
>
> extern "C" int ceph_chdir (struct ceph_mount_info *cmount, const char=
 *s)
> {
> =A0 =A0 =A0 =A0return cmount->get_client()->chdir(s);
> }
>
> It would be very useful to get a uniform error return value rather th=
an
> the fault. Something like this came to mind:
>
> diff --git a/src/libcephfs.cc b/src/libcephfs.cc
> index b1481e6..4751e8f 100644
> --- a/src/libcephfs.cc
> +++ b/src/libcephfs.cc
> @@ -180,6 +180,10 @@ public:
> =A0 =A0 return cct;
> =A0 }
>
> + =A0bool is_mounted(void) {
> + =A0 =A0return mounted;
> + =A0}
> +
> =A0private:
> =A0 uint64_t msgr_nonce;
> =A0 bool mounted;
> @@ -282,6 +286,8 @@ extern "C" const char* ceph_getcwd(struct
> ceph_mount_info *cmount)
>
> =A0extern "C" int ceph_chdir (struct ceph_mount_info *cmount, const c=
har *s)
> =A0{
> + =A0if (!cmount->is_mounted())
> + =A0 =A0return -1004;
> =A0 return cmount->get_client()->chdir(s);
> =A0}
>
> Any thoughts on a good way to handle this?

Also need to check that cmount is initialized.  I'd add a helper:

Client *ceph_get_client(struct ceph_mount_info *cmont)
{
  if (cmount && cmount->is_mounted())
    return cmount->get_client();

  return NULL;
}

extern "C" int ceph_chdir (struct ceph_mount_info *cmount, const char *=
s)
{
  Client *client =3D ceph_get_client(cmount);
  if (!client)
    return -EINVAL;

  return client->chdir(s);
}


>
> -Noah--
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

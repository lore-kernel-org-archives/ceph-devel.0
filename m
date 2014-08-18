From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: Civetweb fixes
Date: Mon, 18 Aug 2014 07:58:36 -0700
Message-ID: <CABBk=J-iAXWJoPn_sNMsUHociFMyYGKSxzV4CV7FnWuSWz9y6g@mail.gmail.com>
References: <CAD_6HTFkdjcanyC19F11jstMrv5hVrUVpnqWhnC2UQ_CCOVgag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:41951 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750768AbaHRO6h (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Aug 2014 10:58:37 -0400
Received: by mail-pa0-f50.google.com with SMTP id et14so8065301pad.9
        for <ceph-devel@vger.kernel.org>; Mon, 18 Aug 2014 07:58:37 -0700 (PDT)
In-Reply-To: <CAD_6HTFkdjcanyC19F11jstMrv5hVrUVpnqWhnC2UQ_CCOVgag@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Benedikt Fraunhofer <fraunhofer@traced.net>, ceph-devel <ceph-devel@vger.kernel.org>

On Mon, Aug 18, 2014 at 7:37 AM, Benedikt Fraunhofer
<fraunhofer@traced.net> wrote:
> Hi Yehuda,
>
> sorry to contact you in person.
> I originally posted that to cephdevel, but it seems this got lost:
> http://comments.gmane.org/gmane.comp.file-systems.ceph.devel/19035
>
> I'm trying to replace our old radosgw with the new civetweb-frontend,
> because ubuntu14.04 ships with apache2.4 and the patched fastcgi-stuff
> isnt there yet for apache2.4;
>
> I just wanted to check with you if you currently have time available to
> to get the civetweb-frontend flying, or if it's on hold due lack of time
> and more important stuff.
> It's also fine if you can only give me a hint at the right direction.
>
> Currently I'm running off  tag     0.80.5
> with these fixes:
>
> diff --git a/src/rgw/rgw_civetweb.cc b/src/rgw/rgw_civetweb.cc
> index a31177f..b44a40c 100644
> --- a/src/rgw/rgw_civetweb.cc
> +++ b/src/rgw/rgw_civetweb.cc
> @@ -42,7 +42,7 @@ int RGWMongoose::complete_request()
>
>        if (0 && data.length() == 0) {
>          has_content_length = true;
> -        print("Transfer-Enconding: %s\n", "chunked");
> +        print("Transfer-Enconding: %s\r\n", "chunked");
>          data.append("0\r\n\r\n", sizeof("0\r\n\r\n")-1);
>        } else {
>          int r = send_content_length(data.length());
> @@ -128,7 +128,7 @@ int RGWMongoose::send_status(const char *status,
> const char *status_name)
>    if (!status_name)
>      status_name = "";
>
> -  snprintf(buf, sizeof(buf), "HTTP/1.1 %s %s\n", status, status_name);
> +  snprintf(buf, sizeof(buf), "HTTP/1.1 %s %s\r\n", status, status_name);
>
>    bufferlist bl;
>    bl.append(buf);
> @@ -168,5 +168,5 @@ int RGWMongoose::send_content_length(uint64_t len)
>    has_content_length = true;
>    char buf[21];
>    snprintf(buf, sizeof(buf), "%"PRIu64, len);
> -  return print("Content-Length: %s\n", buf);
> +  return print("Content-Length: %s\r\n", buf);
>  }
>
> This seems to only affect windows users using some .net function to make
> http-calls and which seem to rely on the presence of the "\r" there.
> It fixes some, but not all of the problems.
>
> I added this one, too:
>
> diff --git a/src/rgw/rgw_rest.cc b/src/rgw/rgw_rest.cc
> index 69948a6..0142e21 100644
> --- a/src/rgw/rgw_rest.cc
> +++ b/src/rgw/rgw_rest.cc
> @@ -244,7 +244,7 @@ void dump_content_length(struct req_state *s, uint64_t len)
>    if (r < 0) {
>      ldout(s->cct, 0) << "ERROR: s->cio->print() returned err=" << r << dendl;
>    }
> -  r = s->cio->print("Accept-Ranges: %s\n", "bytes");
> +  r = s->cio->print("Accept-Ranges: %s\r\n", "bytes");
>    if (r < 0) {
>      ldout(s->cct, 0) << "ERROR: s->cio->print() returned err=" << r << dendl;
>    }
>

Looks fine, can you send  a pull request via github?

> but don't know if that affects the fastcgi-part.
>
> With these fixes, one can do some operations on some files, but e.g.
> setting acls fails for me:
>
> here's the http-log:
> -------------
> T 127.0.0.1:57854 -> 127.0.0.1:2080 [AP]
>   GET /b2d9709c-6a5e-4a7c-9d92-5060b241c254/50%2Dmb.bin?acl HTTP/1.1..User-Ag
>   ent: CloudBerryLab.Base.HttpUtil.Client 3.8.7 (http://www.cloudberrylab.com
>   /)..x-amz-date: Mon, 18 Aug 2014 13:06:38 GMT..Authorization: AWS 9F3CKMDV8
>   18PPXG6BYD4:5X44NdbP2b9af7Uq6e5DnKWhhLo=..Host: ceph1-entry2.ceph1.globalwa
>   ys.net....
> ##
> T 127.0.0.1:2080 -> 127.0.0.1:57854 [AP]
>   HTTP/1.1 403 Forbidden..Content-Length: 78..Accept-Ranges: bytes..Content-t
>   ype: application/xml....
> -------------
>
> and here what radosgw has to say about it:
>
> -------------------
> 2014-08-18 15:06:37.511655 7fc5b4ff9700 10 get_canon_resource():
> dest=/b2d9709c-6a5e-4a7c-9d92-5060b241c254/50-mb.bin?acl
> 2014-08-18 15:06:37.511657 7fc5b4ff9700 10 auth_hdr:
> GET
>
>
>
> x-amz-date:Mon, 18 Aug 2014 13:06:38 GMT
> /b2d9709c-6a5e-4a7c-9d92-5060b241c254/50-mb.bin?acl
> 2014-08-18 15:06:37.511669 7fc5b4ff9700 15 calculated
> digest=ufY9cgyIXx1kYhMJMg+Ss5KJ47o=
> 2014-08-18 15:06:37.511670 7fc5b4ff9700 15
> auth_sign=5X44NdbP2b9af7Uq6e5DnKWhhLo=
> -------------------
>
> The signatures differ because of the last escape "-" (%2D).
> One side calculates it with the last "-" as "%2D" and radosgw decides
> to calculate the signature using the original request, before
> replacing all  %XX occurences, despite logging it with the %-escaped
> stuff already unescaped.

I don't think it's related to your fixes, sounds like issue #8702,
which will make it to the next firefly point release.

Yehuda
>
>
> If I calculate the signatures "by hand" I get the these values, too; I
> just dont know who's doing it wrong,
> because it works if I put the entire apache<>fastcgi<>radosgw chain into place.
> (Maybe it's because the client get's the inital object-name already
> wrongly encoded?)
>
> bf@bfc:~$ s3cmd sign 'GET
>
>
>
> x-amz-date:Mon, 18 Aug 2014 13:06:38 GMT
> /b2d9709c-6a5e-4a7c-9d92-5060b241c254/50-mb.bin?acl'
> Signature: ufY9cgyIXx1kYhMJMg+Ss5KJ47o=
> bf@bfc:~$ s3cmd sign 'GET
>
>
>
> x-amz-date:Mon, 18 Aug 2014 13:06:38 GMT
> /b2d9709c-6a5e-4a7c-9d92-5060b241c254/50%2Dmb.bin?acl'
> Signature: 5X44NdbP2b9af7Uq6e5DnKWhhLo=
>
>
> Thx in advance,
>
>  Benedikt.

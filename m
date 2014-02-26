From: Guang <yguang11-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Subject: Re: PG folder hierarchy
Date: Wed, 26 Feb 2014 12:55:53 +0800
Message-ID: <481F3E29-0BB8-427F-B241-C3BA25356E18@yahoo.com>
References: <21B7D175-AB24-45A8-B64F-AA7BA2E3A215@yahoo.com>
	<CAPYLRzjd6uzdrP13Za5P6gViX_njXu=WzJLLmNq9xSYKswVn-Q@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Content-Type: multipart/mixed; boundary="===============0282530015=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAPYLRzjd6uzdrP13Za5P6gViX_njXu=WzJLLmNq9xSYKswVn-Q-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
To: Gregory Farnum <greg-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
Cc: Ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, Ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org


--===============0282530015==
Content-Type: multipart/alternative; boundary="Apple-Mail=_5B1CFC85-BE22-46F7-BECD-4B96E3B04F35"


--Apple-Mail=_5B1CFC85-BE22-46F7-BECD-4B96E3B04F35
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=iso-8859-1

Got it. Thanks Greg for the response!

Thanks,
Guang

On Feb 26, 2014, at 11:51 AM, Gregory Farnum <greg-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org> wrote:

> On Tue, Feb 25, 2014 at 7:13 PM, Guang <yguang11-/E1597aS9LQAvxtiuMwx3w@public.gmane.org> wrote:
>> Hello,
>> Most recently when looking at PG's folder splitting, I found that =
there was
>> only one sub folder in the top 3 / 4 levels and start having 16 sub =
folders
>> starting from level 6, what is the design consideration behind this?
>>=20
>> For example, if the PG root folder is '3.1905_head', in the first =
level, it
>> only has one sub folder 'DIR_5' and then one sub folder 'DIR_0', and =
then
>> 'DIR_9', under which there are two sub folders 'DIR_1' and 'DIR_9', =
starting
>> from which, the next level has 16 sub folders.
>>=20
>> If we start splitting into 16 sub folders in the very first level, we =
may
>> potential gain better performance with less dentry lookup (though =
most
>> likely the root level been cached).
>=20
> It's an implementation detail of the FileStore (the part of the OSD
> that stores data in the filesystem). Each of those folders represents
> an ever-smaller division of the hash space that objects live in. The
> more PGs you have, the less hash space each one covers, so there's
> that trail of folders.
> It's a bit unfortunate, because as you mention it involves more
> metadata memory caching, but fixing it would require some fairly
> detailed code in a critical path. The cost of fixing it and the risk
> of breaking things haven't been worth it yet.
> -Greg
> Software Engineer #42 @ http://inktank.com | http://ceph.com


--Apple-Mail=_5B1CFC85-BE22-46F7-BECD-4B96E3B04F35
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=iso-8859-1

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html =
charset=3Diso-8859-1"></head><body style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: after-white-space;">Got =
it. Thanks Greg for the =
response!<div><br></div><div>Thanks,</div><div>Guang</div><div><br><div><d=
iv>On Feb 26, 2014, at 11:51 AM, Gregory Farnum &lt;<a =
href=3D"mailto:greg-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org">greg-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org</a>&gt; =
wrote:</div><br class=3D"Apple-interchange-newline"><blockquote =
type=3D"cite"><div style=3D"font-size: 14px; font-style: normal; =
font-variant: normal; font-weight: normal; letter-spacing: normal; =
line-height: normal; orphans: auto; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: auto; word-spacing: =
0px; -webkit-text-stroke-width: 0px;">On Tue, Feb 25, 2014 at 7:13 PM, =
Guang &lt;<a href=3D"mailto:yguang11-/E1597aS9LQAvxtiuMwx3w@public.gmane.org">yguang11-/E1597aS9LQAvxtiuMwx3w@public.gmane.org</a>&gt;=
 wrote:<br><blockquote type=3D"cite">Hello,<br>Most recently when =
looking at PG's folder splitting, I found that there was<br>only one sub =
folder in the top 3 / 4 levels and start having 16 sub =
folders<br>starting from level 6, what is the design consideration =
behind this?<br><br>For example, if the PG root folder is '3.1905_head', =
in the first level, it<br>only has one sub folder 'DIR_5' and then one =
sub folder 'DIR_0', and then<br>'DIR_9', under which there are two sub =
folders 'DIR_1' and 'DIR_9', starting<br>from which, the next level has =
16 sub folders.<br><br>If we start splitting into 16 sub folders in the =
very first level, we may<br>potential gain better performance with less =
dentry lookup (though most<br>likely the root level been =
cached).<br></blockquote><br>It's an implementation detail of the =
FileStore (the part of the OSD<br>that stores data in the filesystem). =
Each of those folders represents<br>an ever-smaller division of the hash =
space that objects live in. The<br>more PGs you have, the less hash =
space each one covers, so there's<br>that trail of folders.<br>It's a =
bit unfortunate, because as you mention it involves more<br>metadata =
memory caching, but fixing it would require some fairly<br>detailed code =
in a critical path. The cost of fixing it and the risk<br>of breaking =
things haven't been worth it yet.<br>-Greg<br>Software Engineer #42 =
@<span class=3D"Apple-converted-space">&nbsp;</span><a =
href=3D"http://inktank.com/">http://inktank.com</a><span =
class=3D"Apple-converted-space">&nbsp;</span>|<span =
class=3D"Apple-converted-space">&nbsp;</span><a =
href=3D"http://ceph.com/">http://ceph.com</a></div></blockquote></div><br>=
</div></body></html>=

--Apple-Mail=_5B1CFC85-BE22-46F7-BECD-4B96E3B04F35--

--===============0282530015==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============0282530015==--

From: Janne Johansson <icepic.dz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: download.ceph.com repository changes
Date: Tue, 17 Sep 2019 15:44:13 +0200
Message-ID: <CAA6-MF9fA0kLwyF_ubGpbBijtjHp6NfuYKgu78AAAkZYF2dj-A@mail.gmail.com>
References: <CAC-Np1zTk1G-LF3eJiqzSF8SS=h=Jrr261C4vHdgmmwcqhUeXQ@mail.gmail.com>
 <CAC-Np1zjZJW2iqLVe720u_sxQDTKjoUqL9ftrqKbMcYbZQgYFQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6468761219286283839=="
Return-path: <ceph-users-bounces-a8pt6IJUokc@public.gmane.org>
In-Reply-To: <CAC-Np1zjZJW2iqLVe720u_sxQDTKjoUqL9ftrqKbMcYbZQgYFQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Archive: <https://lists.ceph.io/hyperkitty/list/ceph-users-a8pt6IJUokc@public.gmane.org/>
List-Help: <mailto:ceph-users-request-a8pt6IJUokc@public.gmane.org?subject=help>
List-Post: <mailto:ceph-users-a8pt6IJUokc@public.gmane.org>
List-Subscribe: <mailto:ceph-users-join-a8pt6IJUokc@public.gmane.org>
List-Unsubscribe: <mailto:ceph-users-leave-a8pt6IJUokc@public.gmane.org>
To: Alfredo Deza <adeza-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: "ceph-maintainers-Qp0mS5GaXlQ@public.gmane.org" <ceph-maintainers-Qp0mS5GaXlQ@public.gmane.org>, ceph-users <ceph-users-a8pt6IJUokc@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============6468761219286283839==
Content-Type: multipart/alternative; boundary="0000000000002030cd0592bfeb60"

--0000000000002030cd0592bfeb60
Content-Type: text/plain; charset="UTF-8"

Den tis 17 sep. 2019 kl 15:15 skrev Alfredo Deza <adeza-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>:

> Reviving this old thread.
> * When a release is underway, the repository breaks because syncing
> packages takes hours. The operation is not atomic.
>

Couldn't they be almost atomic?
I believe both "yum" and "apt" would only consider rpms/debs if they are
listed in the repo index files*, so you should be able to copy out rpms and
debs and at the final step "mv" the index files into place, making the
packages visible in a super short time?

*) .xml.gz for rpms, db/ files for debs.

Obviously this is a very small part of the list of problems, but I think
anyone mirroring huge sets of rpms/debs would have faced and solved this
particular nit by now?


-- 
May the most significant bit of your life be positive.

--0000000000002030cd0592bfeb60
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Den tis 17 sep. 2019 kl 15:15 skrev Alfre=
do Deza &lt;<a href=3D"mailto:adeza-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org">adeza-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org</a>&gt;:<b=
r></div><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">Reviving this old thread.<br>* When a release is underway, the r=
epository breaks because syncing<br>
packages takes hours. The operation is not atomic.<br></blockquote><div><br=
></div><div>Couldn&#39;t they be almost atomic?</div><div>I believe both &q=
uot;yum&quot; and &quot;apt&quot; would only consider rpms/debs if they are=
 listed in the repo index files*, so you should be able to copy out rpms an=
d debs and at the final step &quot;mv&quot; the index files into place, mak=
ing the packages visible in a super short time?</div><div>=C2=A0</div></div=
><div>*) .xml.gz for rpms, db/ files for debs.</div><div><br></div><div>Obv=
iously this is a very small part of the list of problems, but I think anyon=
e mirroring huge sets of rpms/debs would have faced and solved this particu=
lar nit by now?</div><div><br></div><div><br></div>-- <br><div dir=3D"ltr" =
class=3D"gmail_signature">May the most significant bit of your life be posi=
tive.<br></div></div>

--0000000000002030cd0592bfeb60--

--===============6468761219286283839==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list -- ceph-users-a8pt6IJUokc@public.gmane.org
To unsubscribe send an email to ceph-users-leave-a8pt6IJUokc@public.gmane.org

--===============6468761219286283839==--

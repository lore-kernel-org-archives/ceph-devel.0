From: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Subject: Re: vi, multiple users
Date: Thu, 31 Dec 2009 12:12:09 -0800
Message-ID: <a37615150912311212h26fda3a3n4718ce33436fec72@mail.gmail.com>
References: <a37615150912301156w2cc0bb07l3035a2176f71d0cf@mail.gmail.com>
	<Pine.LNX.4.64.0912302001370.10847@cobra.newdream.net>
	<a37615150912302031w2f28c7d6u62f8fa94935c0f1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0247203812161456884=="
Return-path: <ceph-devel-bounces@lists.sourceforge.net>
In-Reply-To: <a37615150912302031w2f28c7d6u62f8fa94935c0f1@mail.gmail.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ceph-devel>
List-Post: <mailto:ceph-devel@lists.sourceforge.net>
List-Help: <mailto:ceph-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ceph-devel-bounces@lists.sourceforge.net
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel <ceph-devel@lists.sourceforge.net>
List-Id: ceph-devel.vger.kernel.org

--===============0247203812161456884==
Content-Type: multipart/alternative; boundary=0016e6471b86b69d80047c0bde2f

--0016e6471b86b69d80047c0bde2f
Content-Type: text/plain; charset=ISO-8859-1

On Wed, Dec 30, 2009 at 8:31 PM, Yehuda Sadeh Weinraub
<yehudasa@gmail.com>wrote:

>
>
> On Wed, Dec 30, 2009 at 8:02 PM, Sage Weil <sage@newdream.net> wrote:
>
>>
>> BTW the corruption I was seeing was that the second page was written to
>> the first page (or something very close to that, possibly shifted by a
>> byte?).
>>
>
> I see the last page being written over the first one, also shifted by one
> byte. The rest of the pages are just garbage. Could be just a bug in the
> sync write related functions, wasn't able to isolate it yet.
>

Yes, the problem was in the copy_user_to_page_vector() helper function,
which was broken for the case where more than one page is involved. This has
only affected us in the synchronous write case, so it only happened with
multiple users. Just pushed a fix.

There is another issue I'm not sure about, which we should look at when we
audit the truncation code, and is whether we also need to update the
truncation size in the sync_write case, e.g., something along the line of:

diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 2d88c80..910f970 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -631,6 +631,10 @@ static ssize_t ceph_sync_write(struct file *file, const
char __user *data,
         */
 more:
        len = left;
+
+       if (ci->i_truncate_size < pos + len)
+               ci->i_truncate_size = pos + len;
+
        req = ceph_osdc_new_request(&client->osdc, &ci->i_layout,
                                    ceph_vino(inode), pos, &len,
                                    CEPH_OSD_OP_WRITE, flags,


Yehuda

--0016e6471b86b69d80047c0bde2f
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_quote">On Wed, Dec 30, 2009 at 8:3=
1 PM, Yehuda Sadeh Weinraub <span dir=3D"ltr">&lt;<a href=3D"mailto:yehudas=
a@gmail.com">yehudasa@gmail.com</a>&gt;</span> wrote:<br><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex;">
<div dir=3D"ltr"><br><br><div class=3D"gmail_quote"><div class=3D"im">On We=
d, Dec 30, 2009 at 8:02 PM, Sage Weil <span dir=3D"ltr">&lt;<a href=3D"mail=
to:sage@newdream.net" target=3D"_blank">sage@newdream.net</a>&gt;</span> wr=
ote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
<div><div></div><div><br>
</div></div>BTW the corruption I was seeing was that the second page was wr=
itten to<br>
the first page (or something very close to that, possibly shifted by a<br>
byte?).<br></blockquote><div><br></div></div><div>I see the last page being=
 written over the first one, also shifted by one byte. The rest of the page=
s are just garbage. Could be just a bug in the sync write related functions=
, wasn&#39;t able to isolate it yet.</div>

</div></div>
</blockquote></div><br><div>Yes, the problem was in the=A0copy_user_to_page=
_vector() helper function, which was broken for the case where more than on=
e page is involved. This has only affected us in the synchronous write case=
, so it only happened with multiple users. Just pushed a fix.</div>
<div><br></div><div>There is another issue I&#39;m not sure about, which we=
 should look at when we audit the truncation code, and is whether we also n=
eed to update the truncation size in the sync_write case, e.g., something a=
long the line of:</div>
<div><br></div><div><div>diff --git a/fs/ceph/file.c b/fs/ceph/file.c</div>=
<div>index 2d88c80..910f970 100644</div><div>--- a/fs/ceph/file.c</div><div=
>+++ b/fs/ceph/file.c</div><div>@@ -631,6 +631,10 @@ static ssize_t ceph_sy=
nc_write(struct file *file, const char __user *data,</div>
<div>=A0=A0 =A0 =A0 =A0 */</div><div>=A0more:</div><div>=A0=A0 =A0 =A0 =A0l=
en =3D left;</div><div>+</div><div>+ =A0 =A0 =A0 if (ci-&gt;i_truncate_size=
 &lt; pos + len)</div><div>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 ci-&gt;i_truncate_=
size =3D pos + len;</div><div>+</div><div>
=A0=A0 =A0 =A0 =A0req =3D ceph_osdc_new_request(&amp;client-&gt;osdc, &amp;=
ci-&gt;i_layout,</div><div>=A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0ceph_vino(inode), pos, &amp;len,</div><div>=A0=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0CEPH=
_OSD_OP_WRITE, flags,</div>
</div><div><br></div><div><br></div><div>Yehuda</div></div>

--0016e6471b86b69d80047c0bde2f--


--===============0247203812161456884==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast and easy
Join now and get one step closer to millions of Verizon customers
http://p.sf.net/sfu/verizon-dev2dev 
--===============0247203812161456884==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ceph-devel mailing list
Ceph-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ceph-devel

--===============0247203812161456884==--

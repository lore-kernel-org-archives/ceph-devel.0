From: Robert LeBlanc <robert-4JaGZRWAfWbajFs6igw21g@public.gmane.org>
Subject: Re: What to do when a parent RBD clone becomes
	corrupted
Date: Mon, 5 Jan 2015 17:46:57 -0700
Message-ID: <CAANLjFqqPD9=91OYdYJ8bQrE88=+AOC0psD5gJUqV0n+JG5Xsg@mail.gmail.com>
References: <CAANLjFqeEqQWimV-A8rzFgAkBrtxRXu3_OUF6waPT7N6J7GL4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2131495851=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAANLjFqeEqQWimV-A8rzFgAkBrtxRXu3_OUF6waPT7N6J7GL4g-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Ceph-User <ceph-users-Qp0mS5GaXlQ@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============2131495851==
Content-Type: multipart/alternative; boundary=f46d043bdf14de0ece050bf1244d

--f46d043bdf14de0ece050bf1244d
Content-Type: text/plain; charset=UTF-8

Now that the holidays are over, I'm going to bump this message to see if
there are any good ideas on this.

Thanks,
Robert LeBlanc

On Thu, Dec 18, 2014 at 2:21 PM, Robert LeBlanc <robert-4JaGZRWAfWbajFs6igw21g@public.gmane.org>
wrote:

> Before we base thousands of VM image clones off of one or more snapshots,
> I want to test what happens when the snapshot becomes corrupted. I don't
> believe the snapshot will become corrupted through client access to the
> snapshot, but some weird issue with PGs being lost or forced to be lost,
> solar flares or alien invasions.
>
> My initial thought was to export a snapshot image and import it over the
> top of the existing snapshot so that children would be preserved. No such
> luck. I was hoping there would be a "i-really-really-want-to-do-this"
> option that would let me restore the snapshot.
>
> Am I going about this the wrong way? I can see having to restore a number
> of VM because of corrupted clone, but I'd hate to lose all the clones
> because of corruption in the snapshot. I would be happy if the restored
> snapshot would be flattened if it was a clone of another image previously.
>
> Thanks,
> Robert LeBlanc
>

--f46d043bdf14de0ece050bf1244d
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Now that the holidays are over, I&#39;m going to bump this=
 message to see if there are any good ideas on this.<div><br></div><div>Tha=
nks,</div><div>Robert LeBlanc</div></div><div class=3D"gmail_extra"><br><di=
v class=3D"gmail_quote">On Thu, Dec 18, 2014 at 2:21 PM, Robert LeBlanc <sp=
an dir=3D"ltr">&lt;<a href=3D"mailto:robert-4JaGZRWAfWbajFs6igw21g@public.gmane.org" target=3D"_blank=
">robert-4JaGZRWAfWbajFs6igw21g@public.gmane.org</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_=
quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1=
ex"><div dir=3D"ltr">Before we base thousands of VM image clones off of one=
 or more snapshots, I want to test what happens when the snapshot becomes c=
orrupted. I don&#39;t believe the snapshot will become corrupted through cl=
ient access to the snapshot, but some weird issue with PGs being lost or fo=
rced to be lost, solar flares or alien invasions.<div><br></div><div>My ini=
tial thought was to export a snapshot image and import it over the top of t=
he existing snapshot so that children would be preserved. No such luck. I w=
as hoping there would be a &quot;i-really-really-want-to-do-this&quot; opti=
on that would let me restore the snapshot.</div><div><br></div><div>Am I go=
ing about this the wrong way? I can see having to restore a number of VM be=
cause of corrupted clone, but I&#39;d hate to lose all the clones because o=
f corruption in the snapshot. I would be happy if the restored snapshot wou=
ld be flattened if it was a clone of another image previously.</div><div><b=
r></div><div>Thanks,</div><div>Robert LeBlanc</div></div>
</blockquote></div><br></div>

--f46d043bdf14de0ece050bf1244d--

--===============2131495851==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============2131495851==--

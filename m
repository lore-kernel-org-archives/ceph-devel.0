From: Joe Julian <joe-Fcm6T8Fmt17HuhbChzYfaQ@public.gmane.org>
Subject: Re: Introducing Tendrl
Date: Tue, 20 Sep 2016 10:09:16 -0700
Message-ID: <C1095376-CEC1-4B8C-9F1A-4157408FEFB5@julianfamily.org>
References: <CAOLAhP1dRqPFuVNPuOXfSktQdHEmuX-88iPb94RkWkm6AbS4+w@mail.gmail.com>
	<CAGrH30W5nz8hb+RcUt+gSPJRPUJ4ptLn2goc-EWsqapBKJSCfw@mail.gmail.com>
	<c89afa54-57b5-3977-2d43-fa730e932a79@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4101869484988502158=="
Return-path: <gluster-devel-bounces-+FkPdpiNhgJAfugRpC6u6w@public.gmane.org>
In-Reply-To: <c89afa54-57b5-3977-2d43-fa730e932a79-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <http://www.gluster.org/mailman/options/gluster-devel>,
	<mailto:gluster-devel-request-+FkPdpiNhgJAfugRpC6u6w@public.gmane.org?subject=unsubscribe>
List-Archive: <http://www.gluster.org/pipermail/gluster-devel/>
List-Post: <mailto:gluster-devel-+FkPdpiNhgJAfugRpC6u6w@public.gmane.org>
List-Help: <mailto:gluster-devel-request-+FkPdpiNhgJAfugRpC6u6w@public.gmane.org?subject=help>
List-Subscribe: <http://www.gluster.org/mailman/listinfo/gluster-devel>,
	<mailto:gluster-devel-request-+FkPdpiNhgJAfugRpC6u6w@public.gmane.org?subject=subscribe>
Sender: gluster-devel-bounces-+FkPdpiNhgJAfugRpC6u6w@public.gmane.org
Errors-To: gluster-devel-bounces-+FkPdpiNhgJAfugRpC6u6w@public.gmane.org
To: Ric Wheeler <rwheeler-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Gerard Braad <me-+lKzbiBlNwRmR6Xm/wNWPw@public.gmane.org>, Mrugesh Karnik <mkarnik-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Ceph Development <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Gluster Development <gluster-devel-+FkPdpiNhgJAfugRpC6u6w@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============4101869484988502158==
Content-Type: multipart/alternative; boundary="----LS8GMLI8I1AF15G02KSXHAMJXEG8LN"
Content-Transfer-Encoding: 7bit

------LS8GMLI8I1AF15G02KSXHAMJXEG8LN
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Does this compare to ViPR?=20

On September 20, 2016 9:52:54 AM PDT, Ric Wheeler <rwheeler-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> w=
rote:
>On 09/20/2016 10:23 AM, Gerard Braad wrote:
>> Hi Mrugesh,
>>
>> On Tue, Sep 20, 2016 at 3:10 PM, Mrugesh Karnik <mkarnik-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
>wrote:
>>> I'd like to introduce the Tendrl project. Tendrl aims to build a
>>> management interface for Ceph. We've pushed some documentation to
>the
>> On Tue, Sep 20, 2016 at 3:15 PM, Mrugesh Karnik <mkarnik-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
>wrote:
>>> I'd like to introduce the Tendrl project. Tendrl aims to build a
>>> management interface for Gluster. We've pushed some documentation to
>> It might help to introduce Tendrl as the "Universal Storage Manager'"
>> with a possibility to either manage Ceph and/or Gluster.
>> I understand you want specific feedback, but a clear definition of
>the
>> tool would be helpful.
>>
>
>(Apologies for reposting my response - gmail injected html into what I
>thought=20
>was a text reply and it bounced from ceph-devel.)
>
>Hi Gerard,
>
>I see the goal differently.
>
>It is better to think of tendryl as one component of a whole management
>
>application stack. At the bottom, we will have ceph specific components
>
>(ceph-mgr) and gluster specific components (glusterd), as well as other
>local=20
>storage/file system components like libstoragemgt and so on.
>
>Tendryl is the next layer up from that, but it itself is meant to be
>consumed by=20
>presentation layers. For a stand alone thing that we hope to use at Red
>Hat,=20
>there will be a universal storage manager stack with everything I
>mentioned=20
>above in it, as well as the GUI code.
>
>Other projects will hopefully find this useful enough and plug some or
>all of=20
>the components into other management stacks.
>
From my point of view, the job is to try to provide as much as possible
>
>re-usable components that will be generically interesting to a wide
>variety of=20
>applications. It is definitely not about trying to make all storage
>stacks look=20
>the same and force artificial new names/concepts/etc on the users. Of
>course,=20
>any one application will tend to have a similar "skin" for UX elements
>to try=20
>and make it consistent for users.
>
>If we do it right, people passionate about Ceph but who don't care
>about Gluster=20
>will be able to be avoid getting tied up in something out of their
>interest.=20
>Same going the other way around for Gluster developers who don't care
>or know=20
>about Ceph. Over time, this might extend to other storage types like
>Samba or=20
>NFS Ganesha clusters, etc.
>
>Regards,
>
>Ric
>
>
>
>
>_______________________________________________
>Gluster-devel mailing list
>Gluster-devel-+FkPdpiNhgJAfugRpC6u6w@public.gmane.org
>http://www.gluster.org/mailman/listinfo/gluster-devel

--=20
Sent from my Android device with K-9 Mail. Please excuse my brevity.
------LS8GMLI8I1AF15G02KSXHAMJXEG8LN
Content-Type: text/html;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head></head><body>Does this compare to ViPR? <br><br><div class=3D=
"gmail_quote">On September 20, 2016 9:52:54 AM PDT, Ric Wheeler &lt;rwhee=
ler-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org&gt; wrote:<blockquote class=3D"gmail_quote" style=3D"margi=
n: 0pt 0pt 0pt 0.8ex; border-left: 1px solid rgb(204, 204, 204); padding-=
left: 1ex;">
<pre class=3D"k9mail">On 09/20/2016 10:23 AM, Gerard Braad wrote:<br /><b=
lockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 1ex 0.8ex; borde=
r-left: 1px solid #729fcf; padding-left: 1ex;"> Hi Mrugesh,<br /><br /> O=
n Tue, Sep 20, 2016 at 3:10 PM, Mrugesh Karnik &lt;mkarnik-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org&gt;=
 wrote:<br /><blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 1=
ex 0.8ex; border-left: 1px solid #ad7fa8; padding-left: 1ex;"> I'd like t=
o introduce the Tendrl project. Tendrl aims to build a<br /> management i=
nterface for Ceph. We've pushed some documentation to the<br /></blockquo=
te> On Tue, Sep 20, 2016 at 3:15 PM, Mrugesh Karnik &lt;mkarnik-H+wXaHxf7aJhl2p70BpVqQ@public.gmane.org=
m&gt; wrote:<br /><blockquote class=3D"gmail_quote" style=3D"margin: 0pt =
0pt 1ex 0.8ex; border-left: 1px solid #ad7fa8; padding-left: 1ex;"> I'd l=
ike to introduce the Tendrl project. Tendrl aims to build a<br /> managem=
ent interface for Gluster. We've pushed some documentation to<br /></bloc=
kquote> It might help to introduce Tendrl as the "Universal
Storage Manager'"<br /> with a possibility to either manage Ceph and/or G=
luster.<br /> I understand you want specific feedback, but a clear defini=
tion of the<br /> tool would be helpful.</blockquote><br /><br />(Apologi=
es for reposting my response - gmail injected html into what I thought <b=
r />was a text reply and it bounced from ceph-devel.)<br /><br />Hi Gerar=
d,<br /><br />I see the goal differently.<br /><br />It is better to thin=
k of tendryl as one component of a whole management <br />application sta=
ck. At the bottom, we will have ceph specific components <br />(ceph-mgr)=
 and gluster specific components (glusterd), as well as other local <br /=
>storage/file system components like libstoragemgt and so on.<br /><br />=
Tendryl is the next layer up from that, but it itself is meant to be cons=
umed by <br />presentation layers. For a stand alone thing that we hope t=
o use at Red Hat, <br />there will be a universal storage manager stack w=
ith everything I mentioned <br />above in it, as
well as the GUI code.<br /><br />Other projects will hopefully find this =
useful enough and plug some or all of <br />the components into other man=
agement stacks.<br /><br /> From my point of view, the job is to try to p=
rovide as much as possible <br />re-usable components that will be generi=
cally interesting to a wide variety of <br />applications. It is definite=
ly not about trying to make all storage stacks look <br />the same and fo=
rce artificial new names/concepts/etc on the users. Of course, <br />any =
one application will tend to have a similar "skin" for UX elements to try=
 <br />and make it consistent for users.<br /><br />If we do it right, pe=
ople passionate about Ceph but who don't care about Gluster <br />will be=
 able to be avoid getting tied up in something out of their interest. <br=
 />Same going the other way around for Gluster developers who don't care =
or know <br />about Ceph. Over time, this might extend to other storage t=
ypes like Samba or <br />NFS Ganesha clusters,
etc.<br /><br />Regards,<br /><br />Ric<br /><br /><br /><br /><br /><hr =
/><br />Gluster-devel mailing list<br />Gluster-devel-+FkPdpiNhgJAfugRpC6u6w@public.gmane.org<br /><a=
 href=3D"http://www.gluster.org/mailman/listinfo/gluster-devel">http://ww=
w.gluster.org/mailman/listinfo/gluster-devel</a><br /></pre></blockquote>=
</div><br>
-- <br>
Sent from my Android device with K-9 Mail. Please excuse my brevity.</bod=
y></html>
------LS8GMLI8I1AF15G02KSXHAMJXEG8LN--


--===============4101869484988502158==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Gluster-devel mailing list
Gluster-devel-+FkPdpiNhgJAfugRpC6u6w@public.gmane.org
http://www.gluster.org/mailman/listinfo/gluster-devel
--===============4101869484988502158==--

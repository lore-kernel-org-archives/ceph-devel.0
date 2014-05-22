From: Craig Lewis <clewis-04jk9TcbgGYP2IHM84UzcNBPR1lH4CV8@public.gmane.org>
Subject: Re: 70+  OSD are DOWN and not coming up
Date: Thu, 22 May 2014 00:26:52 -0700
Message-ID: <537DA6BC.20704@centraldesktop.com>
References: <5396D45F-E87E-4F53-85D8-B4DC1F630B78@csc.fi>
	<alpine.DEB.2.00.1405200815570.1689@cobra.newdream.net>
	<537D541D.2010005@centraldesktop.com>
	<alpine.DEB.2.00.1405212111030.12847@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0737283096=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <alpine.DEB.2.00.1405212111030.12847-vIokxiIdD2AQNTJnQDzGJqxOck334EZe@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Sage Weil <sage-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
Cc: ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ceph Community <ceph-community-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

This is a multi-part message in MIME format.
--===============0737283096==
Content-Type: multipart/alternative;
 boundary="------------070504080609030502010004"

This is a multi-part message in MIME format.
--------------070504080609030502010004
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit

On 5/21/14 21:15 , Sage Weil wrote:
> On Wed, 21 May 2014, Craig Lewis wrote:
>> If you do this over IRC, can you please post a summary to the mailling
>> list?
>>
>> I believe I'm having this issue as well.
> In the other case, we found that some of the OSDs were behind processing
> maps (by several thousand epochs).  The trick here to give them a chance
> to catch up is
>
>   ceph osd set noup
>   ceph osd set nodown
>   ceph osd set noout
>
> and wait for them to stop spinning on the CPU.  You can check which map
> each OSD is on with
>
>   ceph daemon osd.NNN status
>
> to see which epoch they are on and compare that to
>
>   ceph osd stat
>
> Once they are within 100 or less epochs,
>
>   ceph osd unset noup
>
> and let them all start up.
>
> We haven't determined whether the original problem was caused by this or
> the other way around; we'll see once they are all caught up.
>
> sage

I was seeing the CPU spinning too, so I think it is the same issue. 
Thanks for the explanation!  I've been pulling my hair out for weeks.


I can give you a data point for the "how".  My problems started with a 
kswapd problem on 12.04.04 (kernel 3.5.0-46-generic 
#70~precise1-Ubuntu).  kswapd was consuming 100% CPU, and it was 
blocking the ceph-osd processes.  Once I prevented kswapd from doing 
that, my OSDs couldn't recover.  noout and nodown didn't help; the OSDs 
would suicide and restart.


Upgrading to Ubuntu 14.04 seems to have helped.  The cluster isn't all 
clear yet, but it's getting better.  The cluster is finally healthy 
after 2 weeks of incomplete and stale.  It's still unresponsive, but 
it's making progress.  I am still seeing OSD's consuming 100% CPU, but 
only the OSDs that are actively deep-scrubing.  Once the deep-scrub 
finishes, the OSD starts behaving again.  They seem to be slowly getting 
better, which matches up with your explanation.


I'll go ahead at set noup.  I don't think it's necessary at this point, 
but it's not going to hurt.

I'm running Emperor, and looks like osd status isn't supported.  Not a 
big deal though.  Deep-scrub has made it through half of the PGs in the 
last 36 hours, so I'll just watch for another day or two. This is a 
slave cluster, so I have that luxury.







-- 

*Craig Lewis*
Senior Systems Engineer
Office +1.714.602.1309
Email clewis-04jk9TcbgGYP2IHM84UzcNBPR1lH4CV8@public.gmane.org <mailto:clewis-04jk9TcbgGYP2IHM84UzcNBPR1lH4CV8@public.gmane.org>

*Central Desktop. Work together in ways you never thought possible.*
Connect with us Website <http://www.centraldesktop.com/>  | Twitter 
<http://www.twitter.com/centraldesktop>  | Facebook 
<http://www.facebook.com/CentralDesktop>  | LinkedIn 
<http://www.linkedin.com/groups?gid=147417>  | Blog 
<http://cdblog.centraldesktop.com/>


--------------070504080609030502010004
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

<html>
  <head>
    <meta content=3D"text/html; charset=3Dwindows-1252"
      http-equiv=3D"Content-Type">
  </head>
  <body bgcolor=3D"#FFFFFF" text=3D"#000000">
    <div class=3D"moz-cite-prefix">On 5/21/14 21:15 , Sage Weil wrote:<br=
>
    </div>
    <blockquote
      cite=3D"mid:alpine.DEB.2.00.1405212111030.12847-vIokxiIdD2AQNTJnQDzGJqxOck334EZe@public.gmane.org"=

      type=3D"cite">
      <pre wrap=3D"">On Wed, 21 May 2014, Craig Lewis wrote:
</pre>
      <blockquote type=3D"cite">
        <pre wrap=3D"">If you do this over IRC, can you please post a sum=
mary to the mailling
list?=A0

I believe I'm having this issue as well.
</pre>
      </blockquote>
      <pre wrap=3D"">
In the other case, we found that some of the OSDs were behind processing =

maps (by several thousand epochs).  The trick here to give them a chance =

to catch up is

 ceph osd set noup
 ceph osd set nodown
 ceph osd set noout

and wait for them to stop spinning on the CPU.  You can check which map=20
each OSD is on with

 ceph daemon osd.NNN status

to see which epoch they are on and compare that to

 ceph osd stat

Once they are within 100 or less epochs,

 ceph osd unset noup

and let them all start up.

We haven't determined whether the original problem was caused by this or =

the other way around; we'll see once they are all caught up.

sage</pre>
    </blockquote>
    <br>
    I was seeing the CPU spinning too, so I think it is the same issue.=A0=

    Thanks for the explanation!=A0 I've been pulling my hair out for
    weeks.=A0 <br>
    <br>
    <br>
    I can give you a data point for the "how".=A0 My problems started wit=
h
    a kswapd problem on 12.04.04 (kernel 3.5.0-46-generic
    #70~precise1-Ubuntu).=A0 kswapd was consuming 100% CPU, and it was
    blocking the ceph-osd processes.=A0 Once I prevented kswapd from doin=
g
    that, my OSDs couldn't recover.=A0 noout and nodown didn't help; the
    OSDs would suicide and restart.<br>
    <br>
    <br>
    Upgrading to Ubuntu 14.04 seems to have helped.=A0 The cluster isn't
    all clear yet, but it's getting better.=A0 The cluster is finally
    healthy after 2 weeks of incomplete and stale.=A0 It's still
    unresponsive, but it's making progress.=A0 I am still seeing OSD's
    consuming 100% CPU, but only the OSDs that are actively
    deep-scrubing.=A0 Once the deep-scrub finishes, the OSD starts
    behaving again.=A0 They seem to be slowly getting better, which
    matches up with your explanation.<br>
    <br>
    <br>
    I'll go ahead at set noup.=A0 I don't think it's necessary at this
    point, but it's not going to hurt.<br>
    <br>
    I'm running Emperor, and looks like osd status isn't supported.=A0 No=
t
    a big deal though.=A0 Deep-scrub has made it through half of the PGs
    in the last 36 hours, so I'll just watch for another day or two.=A0
    This is a slave cluster, so I have that luxury.<br>
    <br>
    <br>
    <br>
    <br>
    <br>
    <br>
    <br>
    <div class=3D"moz-signature">-- <br>
      <div> <span style=3D"font-size:10.0pt; font-family:Arial,
          Helvetica, sans-serif">
          <p> <span style=3D"color:#E35825"> <strong>Craig Lewis</strong>=

            </span><br>
            <span style=3D"color:#78797B"> Senior Systems Engineer<br>
              Office +1.714.602.1309<br>
              Email <a href=3D"mailto:clewis-04jk9TcbgGYP2IHM84UzcNBPR1lH4CV8@public.gmane.org"
                style=3D"color:#78797B;text-decoration:none;">clewis@cent=
raldesktop.com</a>
            </span> </p>
          <p> <span style=3D"color:#4C4D4F"> <strong>Central Desktop.
                Work together in ways you never thought possible.</strong=
>
              <span> <br>
                <span style=3D"color:#78797B"> Connect with us =A0 <a
                    href=3D"http://www.centraldesktop.com/"
                    style=3D"color:#78797B">Website</a> =A0|=A0 <a
                    href=3D"http://www.twitter.com/centraldesktop"
                    style=3D"color:#78797B">Twitter</a> =A0|=A0 <a
                    href=3D"http://www.facebook.com/CentralDesktop"
                    style=3D"color:#78797B">Facebook</a> =A0|=A0 <a
                    href=3D"http://www.linkedin.com/groups?gid=3D147417"
                    style=3D"color:#78797B">LinkedIn</a> =A0|=A0 <a
                    href=3D"http://cdblog.centraldesktop.com/"
                    style=3D"color:#78797B">Blog</a> </span> <br>
              </span></span></p>
        </span>
      </div>
    </div>
  </body>
</html>

--------------070504080609030502010004--

--===============0737283096==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============0737283096==--

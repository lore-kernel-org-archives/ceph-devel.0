From: Ta Ba Tuan <tuantb-QlevPasa8l681eZEIcUDRw@public.gmane.org>
Subject: Re: ceph -w warning "I don't have pgid 0.2c8"?
Date: Thu, 18 Jul 2013 09:56:24 +0700
Message-ID: <51E75958.10806@vccloud.vn>
References: <51E64EE7.3090902@vccloud.vn>
	<CA+4uBUbASJWUME+zOZRh=NrZLEGdJcmwXMoMWvvmgGRzG04C0w@mail.gmail.com>
	<51E75166.9000308@vccloud.vn>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0717626449=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <51E75166.9000308-QlevPasa8l681eZEIcUDRw@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
To: Samuel Just <sam.just-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
Cc: "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ceph-users <ceph-users-Qp0mS5GaXlQ@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

This is a multi-part message in MIME format.
--===============0717626449==
Content-Type: multipart/alternative;
 boundary="------------040004080505040700050700"

This is a multi-part message in MIME format.
--------------040004080505040700050700
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

zombie pgs might occured when i remove some data pools.
but, with pgs in stale state, i can't delete it?

I found this guide, but I don't understand it.
http://ceph.com/docs/next/dev/osd_internals/pg_removal/

Thanks!
--tuantaba

On 07/18/2013 09:22 AM, Ta Ba Tuan wrote:
> I'm using Ceph-0.61.4,
> I removed each osds (2TB) on data hosts and re-create with disks (4TB).
> When converting finish, Ceph warns that have 4 pgs in stale state and 
> warning: i don't have pgid <pgid>
> after, I created 4 pgs by command: ceph pg force_create_pg <pgid>
>
> Now (after the long time), Ceph still warning: "pgmap v57451: 22944 
> pgs: *4 creating*, 22940 active+clean;"
>
> I don't know how to remove those pgs?.
>  Please guiding this error help me!
>
> Thank you!
> --tuantaba
> TA BA TUAN
>
>
> On 07/18/2013 01:16 AM, Samuel Just wrote:
>> What version are you running?  How did you move the osds from 2TB to 4TB?
>> -Sam
>>
>> On Wed, Jul 17, 2013 at 12:59 AM, Ta Ba Tuan<tuantb-QlevPasa8l681eZEIcUDRw@public.gmane.org>  wrote:
>>> Hi everyone,
>>>
>>> I converted every osds from 2TB to 4TB, and when moving complete, show log
>>> Ceph realtime"ceph -w":
>>> displays error: "I don't have pgid 0.2c8"
>>>
>>> after then, I run:  "ceph pg force_create_pg 0.2c8"
>>> Ceph warning: pgmap v55175: 22944 pgs: 1 creating, 22940 active+clean, 3
>>> stale+active+degraded
>>>
>>> then, I can't read/write data to mounted CephFS on Client-side ==> notify on
>>> client side: "Operation not permitted"
>>>
>>> now, "ceph -w" still notify "22944 pgs: 1 creating, 22940 active+clean, 3
>>> stale+active+degraded"
>>> and I don't understand something occuring?
>>> Please, help me!!!
>>>
>>> Thanks to everyone.
>>>
>>> --tuantaba
>>>
>>>
>>>
>>>
>>> _______________________________________________
>>> ceph-users mailing list
>>> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
>>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>>>
>
>
>
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com


--------------040004080505040700050700
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=ISO-8859-1"
      http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <div class="moz-cite-prefix">zombie pgs might occured when i remove
      some data pools.<br>
      but, with pgs in stale state, i can't delete it?<br>
      <br>
      I found this guide, but I don't understand it.<br>
      <a class="moz-txt-link-freetext" href="http://ceph.com/docs/next/dev/osd_internals/pg_removal/">http://ceph.com/docs/next/dev/osd_internals/pg_removal/</a><br>
      <br>
      Thanks!<br>
      --tuantaba<br>
      <br>
      On 07/18/2013 09:22 AM, Ta Ba Tuan wrote:<br>
    </div>
    <blockquote cite="mid:51E75166.9000308-QlevPasa8l681eZEIcUDRw@public.gmane.org" type="cite">
      <meta content="text/html; charset=ISO-8859-1"
        http-equiv="Content-Type">
      <div class="moz-cite-prefix">I'm using Ceph-0.61.4,<br>
        I removed each osds (2TB) on data hosts and re-create with disks
        (4TB).<br>
        When converting finish, Ceph warns that have 4 pgs in stale
        state and warning: i don't have pgid &lt;pgid&gt;<br>
        after, I created 4 pgs by command: ceph pg force_create_pg
        &lt;pgid&gt;<br>
        <br>
        Now (after the long time), Ceph still warning: "pgmap v57451:
        22944 pgs: <b>4 creating</b>, 22940 active+clean;"<br>
        <br>
        I don't know how to remove those pgs?.<br>
        &nbsp;Please guiding this error help me!<br>
        <br>
        Thank you!<br>
        --tuantaba<br>
        TA BA TUAN<br>
        <br>
        <br>
        On 07/18/2013 01:16 AM, Samuel Just wrote:<br>
      </div>
      <blockquote
cite="mid:CA+4uBUbASJWUME+zOZRh=NrZLEGdJcmwXMoMWvvmgGRzG04C0w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org"
        type="cite">
        <pre wrap="">What version are you running?  How did you move the osds from 2TB to 4TB?
-Sam

On Wed, Jul 17, 2013 at 12:59 AM, Ta Ba Tuan <a moz-do-not-send="true" class="moz-txt-link-rfc2396E" href="mailto:tuantb-QlevPasa8l681eZEIcUDRw@public.gmane.org">&lt;tuantb-QlevPasa8l681eZEIcUDRw@public.gmane.org&gt;</a> wrote:
</pre>
        <blockquote type="cite">
          <pre wrap="">Hi everyone,

I converted every osds from 2TB to 4TB, and when moving complete, show log
Ceph realtime"ceph -w":
displays error: "I don't have pgid 0.2c8"

after then, I run:  "ceph pg force_create_pg 0.2c8"
Ceph warning: pgmap v55175: 22944 pgs: 1 creating, 22940 active+clean, 3
stale+active+degraded

then, I can't read/write data to mounted CephFS on Client-side ==&gt; notify on
client side: "Operation not permitted"

now, "ceph -w" still notify "22944 pgs: 1 creating, 22940 active+clean, 3
stale+active+degraded"
and I don't understand something occuring?
Please, help me!!!

Thanks to everyone.

--tuantaba




_______________________________________________
ceph-users mailing list
<a moz-do-not-send="true" class="moz-txt-link-abbreviated" href="mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a>
<a moz-do-not-send="true" class="moz-txt-link-freetext" href="http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com">http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com</a>

</pre>
        </blockquote>
      </blockquote>
      <br>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <br>
      <pre wrap="">_______________________________________________
ceph-users mailing list
<a class="moz-txt-link-abbreviated" href="mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a>
<a class="moz-txt-link-freetext" href="http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com">http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com</a>
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------040004080505040700050700--

--===============0717626449==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============0717626449==--

From: Ta Ba Tuan <tuantb-QlevPasa8l681eZEIcUDRw@public.gmane.org>
Subject: Re: ceph -w warning "I don't have pgid 0.2c8"?
Date: Thu, 18 Jul 2013 09:22:30 +0700
Message-ID: <51E75166.9000308@vccloud.vn>
References: <51E64EE7.3090902@vccloud.vn>
	<CA+4uBUbASJWUME+zOZRh=NrZLEGdJcmwXMoMWvvmgGRzG04C0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1507145264=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CA+4uBUbASJWUME+zOZRh=NrZLEGdJcmwXMoMWvvmgGRzG04C0w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
--===============1507145264==
Content-Type: multipart/alternative;
 boundary="------------010209090901090406040705"

This is a multi-part message in MIME format.
--------------010209090901090406040705
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I'm using Ceph-0.61.4,
I removed each osds (2TB) on data hosts and re-create with disks (4TB).
When converting finish, Ceph warns that have 4 pgs in stale state and 
warning: i don't have pgid <pgid>
after, I created 4 pgs by command: ceph pg force_create_pg <pgid>

Now (after the long time), Ceph still warning: "pgmap v57451: 22944 pgs: 
*4 creating*, 22940 active+clean;"

I don't know how to remove those pgs?.
  Please guiding this error help me!

Thank you!
--tuantaba
TA BA TUAN


On 07/18/2013 01:16 AM, Samuel Just wrote:
> What version are you running?  How did you move the osds from 2TB to 4TB?
> -Sam
>
> On Wed, Jul 17, 2013 at 12:59 AM, Ta Ba Tuan<tuantb-QlevPasa8l681eZEIcUDRw@public.gmane.org>  wrote:
>> Hi everyone,
>>
>> I converted every osds from 2TB to 4TB, and when moving complete, show log
>> Ceph realtime"ceph -w":
>> displays error: "I don't have pgid 0.2c8"
>>
>> after then, I run:  "ceph pg force_create_pg 0.2c8"
>> Ceph warning: pgmap v55175: 22944 pgs: 1 creating, 22940 active+clean, 3
>> stale+active+degraded
>>
>> then, I can't read/write data to mounted CephFS on Client-side ==> notify on
>> client side: "Operation not permitted"
>>
>> now, "ceph -w" still notify "22944 pgs: 1 creating, 22940 active+clean, 3
>> stale+active+degraded"
>> and I don't understand something occuring?
>> Please, help me!!!
>>
>> Thanks to everyone.
>>
>> --tuantaba
>>
>>
>>
>>
>> _______________________________________________
>> ceph-users mailing list
>> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>>


--------------010209090901090406040705
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=ISO-8859-1"
      http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <div class="moz-cite-prefix">I'm using Ceph-0.61.4,<br>
      I removed each osds (2TB) on data hosts and re-create with disks
      (4TB).<br>
      When converting finish, Ceph warns that have 4 pgs in stale state
      and warning: i don't have pgid &lt;pgid&gt;<br>
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

On Wed, Jul 17, 2013 at 12:59 AM, Ta Ba Tuan <a class="moz-txt-link-rfc2396E" href="mailto:tuantb-QlevPasa8l681eZEIcUDRw@public.gmane.org">&lt;tuantb-QlevPasa8l681eZEIcUDRw@public.gmane.org&gt;</a> wrote:
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
<a class="moz-txt-link-abbreviated" href="mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a>
<a class="moz-txt-link-freetext" href="http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com">http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com</a>

</pre>
      </blockquote>
    </blockquote>
    <br>
  </body>
</html>

--------------010209090901090406040705--

--===============1507145264==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============1507145264==--

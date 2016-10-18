From: =?UTF-8?B?RnLDqWTDqXJpYyBOYXNz?= <frederic.nass-mHc8WM8rKNgDTEWcYJR2Ng@public.gmane.org>
Subject: Re: Ceph + VMWare
Date: Tue, 18 Oct 2016 12:17:31 +0200
Message-ID: <7668a4fa-ad86-30c8-f211-3969b21c58e4@univ-lorraine.fr>
References: <CAAZbbf1HGbZVbB1m5vPd+afWb0pZz4haQhua4FcQa-31FPg=0g@mail.gmail.com>
	<CADb9453mfXcgxMuOMvbz12XDB02bbzuaV-Jtoiqd04n7XuSzJg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1539261135=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CADb9453mfXcgxMuOMvbz12XDB02bbzuaV-Jtoiqd04n7XuSzJg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Alex Gorbachev <ag-VxEtxStO0vCD5NdjQRoWIEEOCMrvLtNR@public.gmane.org>
Cc: Ceph Devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ceph-User <ceph-users-Qp0mS5GaXlQ@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

This is a multi-part message in MIME format.
--===============1539261135==
Content-Type: multipart/alternative;
 boundary="------------CEC3C025BB7A4E2DE9155CFE"

This is a multi-part message in MIME format.
--------------CEC3C025BB7A4E2DE9155CFE
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Alex,

Just to know, what kind of backstore are you using whithin Storcium ? 
vdisk_fileio or vdisk_blockio ?

I see your agents can handle both : 
http://www.spinics.net/lists/ceph-users/msg27817.html

Regards,

Frédéric.


Le 06/10/2016 à 16:01, Alex Gorbachev a écrit :
> On Wed, Oct 5, 2016 at 2:32 PM, Patrick McGarry <pmcgarry-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
>> Hey guys,
>>
>> Starting to buckle down a bit in looking at how we can better set up
>> Ceph for VMWare integration, but I need a little info/help from you
>> folks.
>>
>> If you currently are using Ceph+VMWare, or are exploring the option,
>> I'd like some simple info from you:
>>
>> 1) Company
>> 2) Current deployment size
>> 3) Expected deployment growth
>> 4) Integration method (or desired method) ex: iscsi, native, etc
>>
>> Just casting the net so we know who is interested and might want to
>> help us shape and/or test things in the future if we can make it
>> better. Thanks.
>>
> Hi Patrick,
>
> We have Storcium certified with VMWare, and we use it ourselves:
>
> Ceph Hammer latest
>
> SCST redundant Pacemaker based delivery front ends - our agents are
> published on github
>
> EnhanceIO for read caching at delivery layer
>
> NFS v3, and iSCSI and FC delivery
>
> Our deployment size we use ourselves is 700 TB raw.
>
> Challenges are as others described, but HA and multi host access works
> fine courtesy of SCST.  Write amplification is a challenge on spinning
> disks.
>
> Happy to share more.
>
> Alex
>
>> --
>>
>> Best Regards,
>>
>> Patrick McGarry
>> Director Ceph Community || Red Hat
>> http://ceph.com  ||  http://community.redhat.com
>> @scuttlemonkey || @ceph
>> _______________________________________________
>> ceph-users mailing list
>> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


--------------CEC3C025BB7A4E2DE9155CFE
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <p>Hi Alex,</p>
    <p>Just to know, what kind of backstore are you using whithin
      Storcium ? <span class="pl-s">vdisk_fileio or vdisk_blockio ?</span></p>
    <p><span class="pl-s">I see your agents can handle both :
        <a class="moz-txt-link-freetext" href="http://www.spinics.net/lists/ceph-users/msg27817.html">http://www.spinics.net/lists/ceph-users/msg27817.html</a></span></p>
    <p><span class="pl-s">Regards,</span></p>
    <p><span class="pl-s">Frédéric.<br>
      </span></p>
    <br>
    <div class="moz-cite-prefix">Le 06/10/2016 à 16:01, Alex Gorbachev a
      écrit :<br>
    </div>
    <blockquote
cite="mid:CADb9453mfXcgxMuOMvbz12XDB02bbzuaV-Jtoiqd04n7XuSzJg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org"
      type="cite">
      <pre wrap="">On Wed, Oct 5, 2016 at 2:32 PM, Patrick McGarry <a class="moz-txt-link-rfc2396E" href="mailto:pmcgarry-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org">&lt;pmcgarry-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org&gt;</a> wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="">Hey guys,

Starting to buckle down a bit in looking at how we can better set up
Ceph for VMWare integration, but I need a little info/help from you
folks.

If you currently are using Ceph+VMWare, or are exploring the option,
I'd like some simple info from you:

1) Company
2) Current deployment size
3) Expected deployment growth
4) Integration method (or desired method) ex: iscsi, native, etc

Just casting the net so we know who is interested and might want to
help us shape and/or test things in the future if we can make it
better. Thanks.

</pre>
      </blockquote>
      <pre wrap="">
Hi Patrick,

We have Storcium certified with VMWare, and we use it ourselves:

Ceph Hammer latest

SCST redundant Pacemaker based delivery front ends - our agents are
published on github

EnhanceIO for read caching at delivery layer

NFS v3, and iSCSI and FC delivery

Our deployment size we use ourselves is 700 TB raw.

Challenges are as others described, but HA and multi host access works
fine courtesy of SCST.  Write amplification is a challenge on spinning
disks.

Happy to share more.

Alex

</pre>
      <blockquote type="cite">
        <pre wrap="">
--

Best Regards,

Patrick McGarry
Director Ceph Community || Red Hat
<a class="moz-txt-link-freetext" href="http://ceph.com">http://ceph.com</a>  ||  <a class="moz-txt-link-freetext" href="http://community.redhat.com">http://community.redhat.com</a>
@scuttlemonkey || @ceph
_______________________________________________
ceph-users mailing list
<a class="moz-txt-link-abbreviated" href="mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a>
<a class="moz-txt-link-freetext" href="http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com">http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com</a>
</pre>
      </blockquote>
      <pre wrap="">--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
the body of a message to <a class="moz-txt-link-abbreviated" href="mailto:majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org">majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org</a>
More majordomo info at  <a class="moz-txt-link-freetext" href="http://vger.kernel.org/majordomo-info.html">http://vger.kernel.org/majordomo-info.html</a>
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------CEC3C025BB7A4E2DE9155CFE--

--===============1539261135==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============1539261135==--

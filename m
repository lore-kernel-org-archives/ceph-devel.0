From: Michael Kuriger <mk7193-CivJcMWXhi0@public.gmane.org>
Subject: Re: who is using radosgw with civetweb?
Date: Thu, 26 Feb 2015 15:32:26 +0000
Message-ID: <D1147C43.12E64%mk7193@yp.com>
References: <alpine.DEB.2.00.1502251125180.25838@cobra.newdream.net>
	<CAANLjFpHND2uyUvdzJ-pz4QOXp6SpYK=sD1WQz=rT-Two6izqw@mail.gmail.com>
	<alpine.DEB.2.00.1502251348170.25838@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <alpine.DEB.2.00.1502251348170.25838-vIokxiIdD2AQNTJnQDzGJqxOck334EZe@public.gmane.org>
Content-Language: en-US
Content-ID: <08A3CCC3BB62594198E9807165473E78-CivJcMWXhi0@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Sage Weil <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Robert LeBlanc <robert-4JaGZRWAfWbajFs6igw21g@public.gmane.org>
Cc: ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ceph-User <ceph-users-Qp0mS5GaXlQ@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

I=B9d also like to set this up.  I=B9m not sure where to begin.  When you s=
ay
enabled by default, where is it enabled?

Many thanks,
Mike


On 2/25/15, 1:49 PM, "Sage Weil" <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:

>On Wed, 25 Feb 2015, Robert LeBlanc wrote:
>> We tried to get radosgw working with Apache + mod_fastcgi, but due to
>> the changes in radosgw, Apache, mode_*cgi, etc and the documentation
>> lagging and not having a lot of time to devote to it, we abandoned it.
>> Where it the documentation for civetweb? If it is appliance like and
>> easy to set-up, we would like to try it to offer some feedback on your
>> question.
>
>In giant and hammer, it is enabled by default on port 7480.  On firefly,
>you need to add the line
>
> rgw frontends =3D fastcgi, civetweb port=3D7480
>
>to ceph.conf (you can of course adjust the port number if you like) and
>radosgw will run standalone w/ no apache or anything else.
>
>sage
>
>
>> =

>> Thanks,
>> Robert LeBlanc
>> =

>> On Wed, Feb 25, 2015 at 12:31 PM, Sage Weil <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
>> > Hey,
>> >
>> > We are considering switching to civetweb (the embedded/standalone rgw
>>web
>> > server) as the primary supported RGW frontend instead of the current
>> > apache + mod-fastcgi or mod-proxy-fcgi approach.  "Supported" here
>>means
>> > both the primary platform the upstream development focuses on and
>>what the
>> > downstream Red Hat product will officially support.
>> >
>> > How many people are using RGW standalone using the embedded civetweb
>> > server instead of apache?  In production?  At what scale?  What
>> > version(s) (civetweb first appeared in firefly and we've backported
>>most
>> > fixes).
>> >
>> > Have you seen any problems?  Any other feedback?  The hope is to
>>(vastly)
>> > simplify deployment.
>> >
>> > Thanks!
>> > sage
>> > _______________________________________________
>> > ceph-users mailing list
>> > ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
>> > =

>>https://urldefense.proofpoint.com/v2/url?u=3Dhttp-3A__lists.ceph.com_list=
in
>>fo.cgi_ceph-2Dusers-2Dceph.com&d=3DAwICAg&c=3DlXkdEK1PC7UK9oKA-BBSI8p1Aam=
zLOS
>>ncm6Vfn0C_UQ&r=3DCSYA9OS6Qd7fQySI2LDvlQ&m=3DkDLPSKEyNK6uMLfvU8U7GTva3RMuf=
Ab9w
>>81RjI2K1ZU&s=3DVsyJ8UHWG0ApL86WXaeD5eOV5SRA7VmGeSkKGws3qMI&e=3D
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> More majordomo info at
>>https://urldefense.proofpoint.com/v2/url?u=3Dhttp-3A__vger.kernel.org_maj=
or
>>domo-2Dinfo.html&d=3DAwICAg&c=3DlXkdEK1PC7UK9oKA-BBSI8p1AamzLOSncm6Vfn0C_=
UQ&r
>>=3DCSYA9OS6Qd7fQySI2LDvlQ&m=3DkDLPSKEyNK6uMLfvU8U7GTva3RMufAb9w81RjI2K1ZU=
&s=3Di
>>RNo1K7oJZ-14R-LWuNvEI0WoOr5UuaDkm3IQx77VIo&e=3D
>> =

>> =

>_______________________________________________
>ceph-users mailing list
>ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
>https://urldefense.proofpoint.com/v2/url?u=3Dhttp-3A__lists.ceph.com_listi=
nf
>o.cgi_ceph-2Dusers-2Dceph.com&d=3DAwICAg&c=3DlXkdEK1PC7UK9oKA-BBSI8p1AamzL=
OSnc
>m6Vfn0C_UQ&r=3DCSYA9OS6Qd7fQySI2LDvlQ&m=3DkDLPSKEyNK6uMLfvU8U7GTva3RMufAb9=
w81R
>jI2K1ZU&s=3DVsyJ8UHWG0ApL86WXaeD5eOV5SRA7VmGeSkKGws3qMI&e=3D =

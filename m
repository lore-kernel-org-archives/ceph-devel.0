From: Abhishek L <abhishek.lekshmanan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: RGW Keystone interaction (was  Ceph.conf)
Date: Sat, 12 Sep 2015 13:10:32 +0530
Message-ID: <CAEw75dNPsd51Cy5MSFdcktv3O+0UAhnFGNd1_rg+rhTr-2Retg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Shinobu Kinjo <skinjo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: ajku.agr-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

On Thu, Sep 10, 2015 at 3:27 PM, Shinobu Kinjo <skinjo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> Thank you for letting me know your thought, Abhishek!!
>
>
>     > The Ceph Object Gateway will query Keystone periodically
>     > for a list of revoked tokens. These requests are encoded
>     > and signed. Also, Keystone may be configured to provide
>     > self-signed tokens, which are also encoded and signed.
>

Looked a bit more into this, swift apis seem to support the use
of an admin tenant, user & token for validating the bearer token,
similar to other openstack service which use a service tenant
credentials for authenticating.
 Though it needs documentation, the configurables `rgw keystone admin
tenant`, `rgw keystone admin user` and `rgw keystone admin password`
make this possible, so as to avoid configuring the keystone shared
admin password compoletely.

S3 APIs with keystone seem to be a bit more different, apparently
s3tokens interface does seem to allow authenticating without an
`X-Auth-Token` in the headers and validates based on the access key,
secret key provided to it. So basically not configuring
`rgw_keystone_admin_password` seem to work, can you also see if this
is the case for you.

> This is completely absolutely out of scope of my original
> question.
>
> But I would like to ask you if above implementation that
> **periodically** talks to keystone with tokens is really
> secure or not.
>
> I'm just asking you. Because I'm just thinking of keysto-
> ne federation.
> But you can ignore me anyhow or point out anything to me -;
> Shinobu
>
> ----- Original Message -----
> From: "Abhishek L" <abhishek.lekshmanan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> To: "Shinobu Kinjo" <skinjo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> Cc: "Gregory Farnum" <gfarnum-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "ceph-users" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, "ceph-devel" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
> Sent: Thursday, September 10, 2015 6:35:31 PM
> Subject: Re: [ceph-users] Ceph.conf
>
> On Thu, Sep 10, 2015 at 2:51 PM, Shinobu Kinjo <skinjo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
>> Thank you for your really really quick reply, Greg.
>>
>>  > Yes. A bunch shouldn't ever be set by users.
>>
>>  Anyhow, this is one of my biggest concern right now -;
>>
>>     rgw_keystone_admin_password =
>>                        ^^^^^^^^
>>
>> MUST not be there.
>
>
> I know the dangers of this (ie keystone admin password being visible);
> but isn't this already visible in ceph/radosgw configuration file as
> well if you configure keystone.[1]
>
> [1]: http://ceph.com/docs/master/radosgw/keystone/#integrating-with-openstack-keystone
>
>> Shinobu
>>
>> ----- Original Message -----
>> From: "Gregory Farnum" <gfarnum-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
>> To: "Shinobu Kinjo" <skinjo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
>> Cc: "ceph-users" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, "ceph-devel" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
>> Sent: Thursday, September 10, 2015 5:57:52 PM
>> Subject: Re: [ceph-users] Ceph.conf
>>
>> On Thu, Sep 10, 2015 at 9:44 AM, Shinobu Kinjo <skinjo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
>>> Hello,
>>>
>>> I'm seeing 859 parameters in the output of:
>>>
>>>     $ ./ceph --show-config | wc -l
>>>     *** DEVELOPER MODE: setting PATH, PYTHONPATH and LD_LIBRARY_PATH ***
>>>     859
>>>
>>> In:
>>>
>>>     $ ./ceph --version
>>>     *** DEVELOPER MODE: setting PATH, PYTHONPATH and LD_LIBRARY_PATH ***
>>>     ceph version 9.0.2-1454-g050e1c5 (050e1c5c7471f8f237d9fa119af98c1efa9a8479)
>>>
>>> Since I'm quite new to Ceph, so my question is:
>>>
>>>     Where can I know what each parameter exactly mean?
>>>
>>> I am probably right. Some parameters are just for tes-
>>> ting purpose.
>>
>> Yes. A bunch shouldn't ever be set by users. A lot of the ones that
>> should be are described as part of various operations in
>> ceph.com/docs, but I don't know which ones of interest are missing
>> from there. It's not very discoverable right now, unfortunately.
>> -Greg
>>
>>>
>>> Thank you for your help in advance.
>>>
>>> Shinobu
>>> _______________________________________________
>>> ceph-users mailing list
>>> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
>>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>> _______________________________________________
>> ceph-users mailing list
>> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

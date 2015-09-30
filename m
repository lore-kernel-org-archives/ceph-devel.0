From: Bharath Krishna <BKrishna@walmartlabs.com>
Subject: Re: Teuthology Integration to native openstack
Date: Wed, 30 Sep 2015 05:51:12 +0000
Message-ID: <D23170D5.186E%bkrishna@walmartlabs.com>
References: <D22E3F64.15AF%bkrishna@walmartlabs.com>
 <56084EDE.9050005@dachary.org> <D22ECA7E.15C3%bkrishna@walmartlabs.com>
 <56090D7C.4020000@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from homgw007.wal-mart.com ([161.165.225.36]:59049 "EHLO
	ppes-mail-e5.wal-mart.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753974AbbI3ITj convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 30 Sep 2015 04:19:39 -0400
In-Reply-To: <56090D7C.4020000@dachary.org>
Content-Language: en-US
Content-ID: <0CC711113304F44F8D209862076882AE@email.wal-mart.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>, Ceph Development <ceph-devel@vger.kernel.org>

Hi,

Thanks a lot for pointing to right git and instructions. I have passed
that step now and teuthology VM got created.

But teuthology openstack command fails to parse the instance id from th=
e
json format output of below command:

DEBUG:teuthology.misc:openstack server show -f json teuthology output

 "OS-EXT-STS:task_state": null,
  "addresses": =B3Primary_External_Net=3D<ip-address>",
  "image": "teuthology-ubuntu-14.04
(10e6d3b1-f94a-4220-a00f-3e3a13f349e0)",
  "OS-EXT-STS:vm_state": "active",
  "OS-EXT-SRV-ATTR:instance_name": "instance-000026e8",
  "OS-SRV-USG:launched_at": "2015-09-28T10:33:09.000000",
  "flavor": "m1.small (2)",
  "id": "79a41b6f-f379-4d14-98ac-e73cb42cfa48",
  "security_groups": [
    {
      "name": "teuthology"
    }
  ],
  "user_id": "281f9aa2d9c54177b45e72db742b4744",
  "OS-DCF:diskConfig": "MANUAL",
  "accessIPv4": "",
  "accessIPv6": "",
  "progress": 0,
  "OS-EXT-STS:power_state": 1,
  "OS-EXT-AZ:availability_zone": "az3",
  "config_drive": "",
  "status": "ACTIVE",
  "updated": "2015-09-28T10:33:09Z",
  "hostId": "b205fbea7ee98ef482712db93325a1d7d44d7694a8ec9fce7df038c3",
  "OS-EXT-SRV-ATTR:host": =B3hostname",
  "OS-SRV-USG:terminated_at": null,
  "key_name": "ceph_test_key",
  "properties": "",
  "project_id": "1d0137fe585742bdbe13e2b16daab6ff",
  "OS-EXT-SRV-ATTR:hypervisor_hostname": =B3hostname",
  "name": "teuthology",
  "created": "2015-09-28T10:32:47Z",
  "os-extended-volumes:volumes_attached": []
}
Traceback (most recent call last):
  File "/opt/teuthology/virtualenv/bin/teuthology-openstack", line 9, i=
n
<module>
    load_entry_point('teuthology=3D=3D0.1.0', 'console_scripts',
'teuthology-openstack')()
  File "/opt/teuthology/scripts/openstack.py", line 8, in main
    teuthology.openstack.main(parse_args(argv), argv)
  File "/opt/teuthology/teuthology/openstack/__init__.py", line 622, in
main
    return TeuthologyOpenStack(ctx, teuth_config, argv).main()
  File "/opt/teuthology/teuthology/openstack/__init__.py", line 284, in
main
    ip =3D self.setup()
  File "/opt/teuthology/teuthology/openstack/__init__.py", line 338, in
setup
    if not self.cluster_exists():
  File "/opt/teuthology/teuthology/openstack/__init__.py", line 607, in
cluster_exists
    instance_id =3D self.get_instance_id(self.args.name)
  File "/opt/teuthology/teuthology/openstack/__init__.py", line 565, in
get_instance_id
    return TeuthologyOpenStack.get_value(instance, 'id')
  File "/opt/teuthology/teuthology/openstack/__init__.py", line 75, in
get_value
    return filter(lambda v: v['Field'] =3D=3D field, result)[0]['Value'=
]
  File "/opt/teuthology/teuthology/openstack/__init__.py", line 75, in
<lambda>
    return filter(lambda v: v['Field'] =3D=3D field, result)[0]['Value'=
]
TypeError: string indices must be integers


I could understand that we are trying to get instance id value using
get_value method, but it fails with an exception even though instance i=
d
shown is a valid format of id.

Any pointers to fix this will greatly help.

Thank you.

Regards,
M Bharath Krishna


On 9/28/15, 3:20 PM, "Loic Dachary" <loic@dachary.org> wrote:

>Hi,
>
>On 28/09/2015 07:24, Bharath Krishna wrote:
>> Hi Dachary,
>>=20
>> Thanks for the reply. I am following your blog
>>http://dachary.org/?p=3D3767
>> And the README in
>>=20
>>https://github.com/dachary/teuthology/tree/wip-6502-openstack-v2/#ope=
nsta
>>ck
>> -backend
>
>The up to date instructions are at
>https://github.com/dachary/teuthology/tree/openstack/#openstack-backen=
d
>(the link you used comes from http://dachary.org/?p=3D3828 and I just
>updated it so noone else will be confused).
>>=20
>> I have sourced the openrc file of my Openstack deployment and verifi=
ed
>> that clients are working fine. My Openstack deployment has Cinder
>> integrated with CEPH backend.
>>=20
>> I have cloned and installed teuthology using the below steps:
>>=20
>> $ git clone -b wip-6502-openstack-v2
>>http://github.com/dachary/teuthology
>> $ cd teuthology ; ./bootstrap install
>> $ source virtualenv/bin/activate
>>=20
>>=20
>> Then I tried to run a dummy suite as test and I ran into following
>>error:
>>=20
>> Traceback (most recent call last):
>>   File "/root/teuthology/virtualenv/bin/teuthology-openstack", line =
9,
>>in
>> <module>
>>     load_entry_point('teuthology=3D=3D0.1.0', 'console_scripts',
>> 'teuthology-openstack')()
>>   File "/root/teuthology/scripts/openstack.py", line 8, in main
>>     teuthology.openstack.main(parse_args(argv), argv)
>>   File "/root/teuthology/teuthology/openstack.py", line 375, in main
>>     return TeuthologyOpenStack(ctx, teuth_config, argv).main()
>>   File "/root/teuthology/teuthology/openstack.py", line 181, in main
>>     self.verify_openstack()
>>   File "/root/teuthology/teuthology/openstack.py", line 270, in
>> verify_openstack
>>     str(providers))
>> Exception: ('OS_AUTH_URL=3Dhttp://<ip-address>:5000/v2.0', " does is=
 not a
>> known OpenStack provider (('cloud.ovh.net', 'ovh'), ('control.os1.ph=
x2',
>> 'redhat'), ('entercloudsuite.com', 'entercloudsuite'))")
>
>This limitation was in an earlier implementations and should not be a
>problem now.
>
>Cheers
>
>>=20
>>=20
>> Thank you.
>>=20
>> Regards,
>> M Bharath Krishna
>>=20
>> On 9/28/15, 1:47 AM, "Loic Dachary" <loic@dachary.org> wrote:
>>=20
>>> [moving to ceph-devel]
>>>
>>> Hi,
>>>
>>> On 27/09/2015 21:20, Bharath Krishna wrote:
>>>> Hi,
>>>>
>>>> We have an openstack deployment in place with CEPH as CINDER backe=
nd.
>>>>
>>>> We would like to perform functional testing for CEPH and found
>>>> teuthology as recommended option.
>>>>
>>>> Have successfully installed teuthology. Now to integrate it with
>>>> Openstack, I could see that the possible providers could be either
>>>>OVH,
>>>> REDHAT or ENTERCLOUDSITE.
>>>>
>>>> Is there any option where in we can source openstack deployment of=
 our
>>>> own and test CEPH using teuthology?
>>>
>>> The documentation mentions these providers because they have been
>>>tested.
>>> But there should be no blocker to run teuthology against a regular
>>> OpenStack provider. Should you run into troubles, please let me kno=
w
>>>and
>>> I'll help.
>>>
>>> Cheers
>>>
>>>>
>>>> If NO, please suggest on how to test CEPH in such scenarios?
>>>>
>>>> Please help.
>>>>
>>>> Thank you.
>>>> Bharath Krishna
>>>> _______________________________________________
>>>> ceph-users mailing list
>>>> ceph-users@lists.ceph.com
>>>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>>>>
>>>
>>> --=20
>>> Lo=EFc Dachary, Artisan Logiciel Libre
>>>
>>=20
>
>--=20
>Lo=EFc Dachary, Artisan Logiciel Libre
>

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

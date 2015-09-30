From: Bharath Krishna <BKrishna@walmartlabs.com>
Subject: Re: Teuthology Integration to native openstack
Date: Wed, 30 Sep 2015 09:34:43 +0000
Message-ID: <D231A8D6.18A9%bkrishna@walmartlabs.com>
References: <D22E3F64.15AF%bkrishna@walmartlabs.com>
 <56084EDE.9050005@dachary.org> <D22ECA7E.15C3%bkrishna@walmartlabs.com>
 <56090D7C.4020000@dachary.org> <D23170D5.186E%bkrishna@walmartlabs.com>
 <560BA270.3060409@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1254
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from homgw008.wal-mart.com ([161.165.225.37]:41757 "EHLO
	ppes-mail-e6.wal-mart.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754583AbbI3JhW convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 30 Sep 2015 05:37:22 -0400
In-Reply-To: <560BA270.3060409@dachary.org>
Content-Language: en-US
Content-ID: <836838F3A385314A828B42AF7300A605@email.wal-mart.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>, Ceph Development <ceph-devel@vger.kernel.org>

Hi Loic,

Does piping the command output of "openstack server show -f json
<target-name>=94 to jq alter the output format?

Openstack version being used is Juno.

Thank you

Regards,
M Bharath Krishna

On 9/30/15, 2:20 PM, "Loic Dachary" <loic@dachary.org> wrote:

>Hi,
>
>On 30/09/2015 07:51, Bharath Krishna wrote:
>> Hi,
>>=20
>> Thanks a lot for pointing to right git and instructions. I have pass=
ed
>> that step now and teuthology VM got created.
>>=20
>> But teuthology openstack command fails to parse the instance id from=
 the
>> json format output of below command:
>>=20
>> DEBUG:teuthology.misc:openstack server show -f json teuthology outpu=
t
>>=20
>>  "OS-EXT-STS:task_state": null,
>>   "addresses": =B3Primary_External_Net=3D<ip-address>",
>>   "image": "teuthology-ubuntu-14.04
>> (10e6d3b1-f94a-4220-a00f-3e3a13f349e0)",
>>   "OS-EXT-STS:vm_state": "active",
>>   "OS-EXT-SRV-ATTR:instance_name": "instance-000026e8",
>>   "OS-SRV-USG:launched_at": "2015-09-28T10:33:09.000000",
>>   "flavor": "m1.small (2)",
>>   "id": "79a41b6f-f379-4d14-98ac-e73cb42cfa48",
>>   "security_groups": [
>>     {
>>       "name": "teuthology"
>>     }
>>   ],
>>   "user_id": "281f9aa2d9c54177b45e72db742b4744",
>>   "OS-DCF:diskConfig": "MANUAL",
>>   "accessIPv4": "",
>>   "accessIPv6": "",
>>   "progress": 0,
>>   "OS-EXT-STS:power_state": 1,
>>   "OS-EXT-AZ:availability_zone": "az3",
>>   "config_drive": "",
>>   "status": "ACTIVE",
>>   "updated": "2015-09-28T10:33:09Z",
>>   "hostId": "b205fbea7ee98ef482712db93325a1d7d44d7694a8ec9fce7df038c=
3",
>>   "OS-EXT-SRV-ATTR:host": =B3hostname",
>>   "OS-SRV-USG:terminated_at": null,
>>   "key_name": "ceph_test_key",
>>   "properties": "",
>>   "project_id": "1d0137fe585742bdbe13e2b16daab6ff",
>>   "OS-EXT-SRV-ATTR:hypervisor_hostname": =B3hostname",
>>   "name": "teuthology",
>>   "created": "2015-09-28T10:32:47Z",
>>   "os-extended-volumes:volumes_attached": []
>> }
>> Traceback (most recent call last):
>>   File "/opt/teuthology/virtualenv/bin/teuthology-openstack", line 9=
, in
>> <module>
>>     load_entry_point('teuthology=3D=3D0.1.0', 'console_scripts',
>> 'teuthology-openstack')()
>>   File "/opt/teuthology/scripts/openstack.py", line 8, in main
>>     teuthology.openstack.main(parse_args(argv), argv)
>>   File "/opt/teuthology/teuthology/openstack/__init__.py", line 622,=
 in
>> main
>>     return TeuthologyOpenStack(ctx, teuth_config, argv).main()
>>   File "/opt/teuthology/teuthology/openstack/__init__.py", line 284,=
 in
>> main
>>     ip =3D self.setup()
>>   File "/opt/teuthology/teuthology/openstack/__init__.py", line 338,=
 in
>> setup
>>     if not self.cluster_exists():
>>   File "/opt/teuthology/teuthology/openstack/__init__.py", line 607,=
 in
>> cluster_exists
>>     instance_id =3D self.get_instance_id(self.args.name)
>>   File "/opt/teuthology/teuthology/openstack/__init__.py", line 565,=
 in
>> get_instance_id
>>     return TeuthologyOpenStack.get_value(instance, 'id')
>>   File "/opt/teuthology/teuthology/openstack/__init__.py", line 75, =
in
>> get_value
>>     return filter(lambda v: v['Field'] =3D=3D field, result)[0]['Val=
ue']
>>   File "/opt/teuthology/teuthology/openstack/__init__.py", line 75, =
in
>> <lambda>
>>     return filter(lambda v: v['Field'] =3D=3D field, result)[0]['Val=
ue']
>> TypeError: string indices must be integers
>>=20
>>=20
>> I could understand that we are trying to get instance id value using
>> get_value method, but it fails with an exception even though instanc=
e id
>> shown is a valid format of id.
>>=20
>> Any pointers to fix this will greatly help.
>
>It appears that the format of the json output is very different on you=
r
>implementation. Here is the kind of output I get on all the clusters I
>tried. Which OpenStack version is your cluster running ?
>
>$ openstack server show -f json target225193 | jq .
>[
>  {
>    "Value": "MANUAL",
>    "Field": "OS-DCF:diskConfig"
>  },
>  {
>    "Value": "nova",
>    "Field": "OS-EXT-AZ:availability_zone"
>  },
>  {
>    "Value": 1,
>    "Field": "OS-EXT-STS:power_state"
>  },
>  {
>    "Value": null,
>    "Field": "OS-EXT-STS:task_state"
>  },
>  {
>    "Value": "active",
>    "Field": "OS-EXT-STS:vm_state"
>  },
>  {
>    "Value": "2015-09-30T08:37:55.000000",
>    "Field": "OS-SRV-USG:launched_at"
>  },
>  {
>    "Value": null,
>    "Field": "OS-SRV-USG:terminated_at"
>  },
>  {
>    "Value": "",
>    "Field": "accessIPv4"
>  },
>  {
>    "Value": "",
>    "Field": "accessIPv6"
>  },
>  {
>    "Value": "Ext-Net=3D167.114.225.193",
>    "Field": "addresses"
>  },
>  {
>    "Value": "",
>    "Field": "config_drive"
>  },
>  {
>    "Value": "2015-09-30T08:37:01Z",
>    "Field": "created"
>  },
>  {
>    "Value": "vps-ssd-3 (e43d7458-6b82-4a78-a712-3a4dc6748cf4)",
>    "Field": "flavor"
>  },
>  {
>    "Value": "38119f63edc62252c491fa7e9a8d164a90c48db09fdee1a5687c1c7f=
",
>    "Field": "hostId"
>  },
>  {
>    "Value": "897cbcc9-d662-4ae9-bb68-a71ef4269cdc",
>    "Field": "id"
>  },
>  {
>    "Value": "teuthology-centos-7.0
>(67438ecf-803c-45a6-83bb-54a0ba0d0b6c)",
>    "Field": "image"
>  },
>  {
>    "Value": "teuthology",
>    "Field": "key_name"
>  },
>  {
>    "Value": "target225193",
>    "Field": "name"
>  },
>  {
>    "Value": [],
>    "Field": "os-extended-volumes:volumes_attached"
>  },
>  {
>    "Value": 0,
>    "Field": "progress"
>  },
>  {
>    "Value": "131b886b156a4f84b5f41baf2fbe646c",
>    "Field": "project_id"
>  },
>  {
>    "Value": "ownedby=3D'167.114.249.14',
>teuthology=3D'd48f8bc9adf785614308e33094933a72'",
>    "Field": "properties"
>  },
>  {
>    "Value": [
>      {
>        "name": "teuthology"
>      }
>    ],
>    "Field": "security_groups"
>  },
>  {
>    "Value": "ACTIVE",
>    "Field": "status"
>  },
>  {
>    "Value": "2015-09-30T08:39:08Z",
>    "Field": "updated"
>  },
>  {
>    "Value": "291dde1633154837be2693c6ffa6315c",
>    "Field": "user_id"
>  }
>]
>
>>=20
>> Thank you.
>>=20
>> Regards,
>> M Bharath Krishna
>>=20
>>=20
>> On 9/28/15, 3:20 PM, "Loic Dachary" <loic@dachary.org> wrote:
>>=20
>>> Hi,
>>>
>>> On 28/09/2015 07:24, Bharath Krishna wrote:
>>>> Hi Dachary,
>>>>
>>>> Thanks for the reply. I am following your blog
>>>> http://dachary.org/?p=3D3767
>>>> And the README in
>>>>
>>>>=20
>>>>https://github.com/dachary/teuthology/tree/wip-6502-openstack-v2/#o=
pens
>>>>ta
>>>> ck
>>>> -backend
>>>
>>> The up to date instructions are at
>>> https://github.com/dachary/teuthology/tree/openstack/#openstack-bac=
kend
>>> (the link you used comes from http://dachary.org/?p=3D3828 and I ju=
st
>>> updated it so noone else will be confused).
>>>>
>>>> I have sourced the openrc file of my Openstack deployment and veri=
fied
>>>> that clients are working fine. My Openstack deployment has Cinder
>>>> integrated with CEPH backend.
>>>>
>>>> I have cloned and installed teuthology using the below steps:
>>>>
>>>> $ git clone -b wip-6502-openstack-v2
>>>> http://github.com/dachary/teuthology
>>>> $ cd teuthology ; ./bootstrap install
>>>> $ source virtualenv/bin/activate
>>>>
>>>>
>>>> Then I tried to run a dummy suite as test and I ran into following
>>>> error:
>>>>
>>>> Traceback (most recent call last):
>>>>   File "/root/teuthology/virtualenv/bin/teuthology-openstack", lin=
e 9,
>>>> in
>>>> <module>
>>>>     load_entry_point('teuthology=3D=3D0.1.0', 'console_scripts',
>>>> 'teuthology-openstack')()
>>>>   File "/root/teuthology/scripts/openstack.py", line 8, in main
>>>>     teuthology.openstack.main(parse_args(argv), argv)
>>>>   File "/root/teuthology/teuthology/openstack.py", line 375, in ma=
in
>>>>     return TeuthologyOpenStack(ctx, teuth_config, argv).main()
>>>>   File "/root/teuthology/teuthology/openstack.py", line 181, in ma=
in
>>>>     self.verify_openstack()
>>>>   File "/root/teuthology/teuthology/openstack.py", line 270, in
>>>> verify_openstack
>>>>     str(providers))
>>>> Exception: ('OS_AUTH_URL=3Dhttp://<ip-address>:5000/v2.0', " does =
is
>>>>not a
>>>> known OpenStack provider (('cloud.ovh.net', 'ovh'),
>>>>('control.os1.phx2',
>>>> 'redhat'), ('entercloudsuite.com', 'entercloudsuite'))")
>>>
>>> This limitation was in an earlier implementations and should not be=
 a
>>> problem now.
>>>
>>> Cheers
>>>
>>>>
>>>>
>>>> Thank you.
>>>>
>>>> Regards,
>>>> M Bharath Krishna
>>>>
>>>> On 9/28/15, 1:47 AM, "Loic Dachary" <loic@dachary.org> wrote:
>>>>
>>>>> [moving to ceph-devel]
>>>>>
>>>>> Hi,
>>>>>
>>>>> On 27/09/2015 21:20, Bharath Krishna wrote:
>>>>>> Hi,
>>>>>>
>>>>>> We have an openstack deployment in place with CEPH as CINDER
>>>>>>backend.
>>>>>>
>>>>>> We would like to perform functional testing for CEPH and found
>>>>>> teuthology as recommended option.
>>>>>>
>>>>>> Have successfully installed teuthology. Now to integrate it with
>>>>>> Openstack, I could see that the possible providers could be eith=
er
>>>>>> OVH,
>>>>>> REDHAT or ENTERCLOUDSITE.
>>>>>>
>>>>>> Is there any option where in we can source openstack deployment =
of
>>>>>>our
>>>>>> own and test CEPH using teuthology?
>>>>>
>>>>> The documentation mentions these providers because they have been
>>>>> tested.
>>>>> But there should be no blocker to run teuthology against a regula=
r
>>>>> OpenStack provider. Should you run into troubles, please let me k=
now
>>>>> and
>>>>> I'll help.
>>>>>
>>>>> Cheers
>>>>>
>>>>>>
>>>>>> If NO, please suggest on how to test CEPH in such scenarios?
>>>>>>
>>>>>> Please help.
>>>>>>
>>>>>> Thank you.
>>>>>> Bharath Krishna
>>>>>> _______________________________________________
>>>>>> ceph-users mailing list
>>>>>> ceph-users@lists.ceph.com
>>>>>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>>>>>>
>>>>>
>>>>> --=20
>>>>> Lo=EFc Dachary, Artisan Logiciel Libre
>>>>>
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

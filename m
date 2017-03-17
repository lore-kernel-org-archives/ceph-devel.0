From: Nikita Gerasimov <nikita.gerasimov@oracle.com>
Subject: Re: [PATCH] ceph-detect-init: Adds Oracle Linux Server and Oracle VM
 Server detection
Date: Fri, 17 Mar 2017 16:18:12 +0300
Message-ID: <82a406d9-f838-cce9-b97b-7e96abeab911@oracle.com>
References: <1488473512-4374-1-git-send-email-nikita.gerasimov@oracle.com>
 <c25a3567-c135-b63c-a9c6-af0e854362de@dachary.org>
 <bffcf580-6763-cdc3-3f0c-d045812a2512@oracle.com>
 <f8f6f0c8-8bf8-2132-7744-a1f8b028d6d3@redhat.com>
 <88850a6c-e6a2-87a9-38a4-e1d6433ec5a3@oracle.com>
 <d1ff1137-45ae-e195-8b9b-37473b776e71@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:34535 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751110AbdCQNSb (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 17 Mar 2017 09:18:31 -0400
In-Reply-To: <d1ff1137-45ae-e195-8b9b-37473b776e71@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dan Mick <dmick@redhat.com>, ceph-devel@vger.kernel.org, ldachary@redhat.com

Hi,

Is there any blocking for merge this? Any additional actions required?
The PR does not contain specific comments.


On 10.03.2017 22:15, Dan Mick wrote:
> On 03/10/2017 06:50 AM, Nikita Gerasimov wrote:
>> github pull request: https://github.com/ceph/ceph/pull/13917
> Thanks.
>
>> But https://github.com/ceph/ceph/blob/master/SubmittingPatches.rst say
>> nothing about submission via ceph-devel@vger.kernel.org limitations.
>> It wold be nice if someone correct that.
>    PREPARING AND SENDING PATCHES
> 	.
> 	.
> 	.
>    The preferred way to submit code is by publishing your patches in
>    a branch in your github fork of the ceph repository and then
>    submitting a github pull request.
>
>
> We *could* manage to deal with email patches, and do, for kernel, but
> most of our developers use the 'preferred' way.  If there's some real
> objection or limitation that prevents using github, emailed patches are
> a fallback.
>
>> On 10.03.2017 3:20, Dan Mick wrote:
>>> Generally all our non-kernel submissions come in as github pull
>>> requests.  Could you submit your request that way, Nikita?
>>> There's a lot of documentation at
>>> http://docs.ceph.com/docs/master/dev, specifically
>>> http://docs.ceph.com/docs/master/dev/#github-pull-request
>>>
>>>
>>>
>>> On 03/09/2017 03:03 AM, Nikita Gerasimov wrote:
>>>> Hi All,
>>>>
>>>> What are the next steps for this patch?
>>>>
>>>>
>>>> On 02.03.2017 21:16, Loic Dachary wrote:
>>>>> Reviewed-by: Loic Dachary <ldachary@redhat.com>
>>>>>
>>>>> On 03/02/2017 05:51 PM, nikita.gerasimov@oracle.com wrote:
>>>>>> From: Nikita Gerasimov <nikita.gerasimov@oracle.com>
>>>>>>
>>>>>> Oracle Linux Server is API/ABI compatible with RHEL/CentOS Linux
>>>>>> distro.
>>>>>> Oracle VM Server is Xen based VM server. Which modern versions Dom0
>>>>>> is based on el6
>>>>>>
>>>>>> Signed-off-by: Nikita Gerasimov <nikita.gerasimov@oracle.com>
>>>>>>
>>>>>> run-make-check.sh: http://paste.ubuntu.com/24096418/
>>>>>> ---
>>>>>>     install-deps.sh                                        |  2 +-
>>>>>>     src/ceph-detect-init/ceph_detect_init/__init__.py      | 18
>>>>>> ++++++++++++++++--
>>>>>>     .../ceph_detect_init/oraclevms/__init__.py             | 11
>>>>>> +++++++++++
>>>>>>     src/ceph-detect-init/tests/test_all.py                 | 18
>>>>>> ++++++++++++++++++
>>>>>>     4 files changed, 46 insertions(+), 3 deletions(-)
>>>>>>     create mode 100644
>>>>>> src/ceph-detect-init/ceph_detect_init/oraclevms/__init__.py
>>>>>>
>>>>>> diff --git a/install-deps.sh b/install-deps.sh
>>>>>> index 41d393d..e1e8722 100755
>>>>>> --- a/install-deps.sh
>>>>>> +++ b/install-deps.sh
>>>>>> @@ -88,7 +88,7 @@ else
>>>>>>         $SUDO env DEBIAN_FRONTEND=noninteractive apt-get -y remove
>>>>>> ceph-build-deps
>>>>>>         if [ -n "$backports" ] ; then rm $control; fi
>>>>>>             ;;
>>>>>> -    centos|fedora|rhel)
>>>>>> +    centos|fedora|rhel|ol)
>>>>>>             yumdnf="yum"
>>>>>>             builddepcmd="yum-builddep -y"
>>>>>>             if test "$(echo "$VERSION_ID >= 22" | bc)" -ne 0; then
>>>>>> diff --git a/src/ceph-detect-init/ceph_detect_init/__init__.py
>>>>>> b/src/ceph-detect-init/ceph_detect_init/__init__.py
>>>>>> index aad3eee..9abc421 100644
>>>>>> --- a/src/ceph-detect-init/ceph_detect_init/__init__.py
>>>>>> +++ b/src/ceph-detect-init/ceph_detect_init/__init__.py
>>>>>> @@ -24,6 +24,7 @@ from ceph_detect_init import suse
>>>>>>     from ceph_detect_init import gentoo
>>>>>>     from ceph_detect_init import freebsd
>>>>>>     from ceph_detect_init import docker
>>>>>> +from ceph_detect_init import oraclevms
>>>>>>     import os
>>>>>>     import logging
>>>>>>     import platform
>>>>>> @@ -44,7 +45,8 @@ def get(use_rhceph=False):
>>>>>>         module.normalized_name = _normalized_distro_name(distro_name)
>>>>>>         module.distro = module.normalized_name
>>>>>>         module.is_el = module.normalized_name in ['redhat', 'centos',
>>>>>> -                                              'fedora', 'scientific']
>>>>>> +                                              'fedora', 'scientific',
>>>>>> +                                              'oraclel']
>>>>>>         module.release = release
>>>>>>         module.codename = codename
>>>>>>         module.init = module.choose_init()
>>>>>> @@ -64,6 +66,8 @@ def _get_distro(distro, use_rhceph=False):
>>>>>>             'linuxmint': debian,
>>>>>>             'centos': centos,
>>>>>>             'scientific': centos,
>>>>>> +        'oraclel': centos,
>>>>>> +        'oraclevms': oraclevms,
>>>>>>             'redhat': centos,
>>>>>>             'fedora': fedora,
>>>>>>             'suse': suse,
>>>>>> @@ -90,6 +94,10 @@ def _normalized_distro_name(distro):
>>>>>>             return 'suse'
>>>>>>         elif distro.startswith('centos'):
>>>>>>             return 'centos'
>>>>>> +    elif distro.startswith('oracle linux'):
>>>>>> +        return 'oraclel'
>>>>>> +    elif distro.startswith('oracle vm'):
>>>>>> +        return 'oraclevms'
>>>>>>         elif distro.startswith(('gentoo', 'funtoo', 'exherbo')):
>>>>>>             return 'gentoo'
>>>>>>         return distro
>>>>>> @@ -127,8 +135,9 @@ def platform_information():
>>>>>>         else:
>>>>>>             raise exc.UnsupportedPlatform(platform.system(), '', '')
>>>>>>     +    distro_lower = distro.lower()
>>>>>>         # this could be an empty string in Debian
>>>>>> -    if not codename and 'debian' in distro.lower():
>>>>>> +    if not codename and 'debian' in distro_lower:
>>>>>>             debian_codenames = {
>>>>>>                 '8': 'jessie',
>>>>>>                 '7': 'wheezy',
>>>>>> @@ -146,6 +155,11 @@ def platform_information():
>>>>>>                     codename = minor
>>>>>>                 else:
>>>>>>                     codename = major
>>>>>> +    # this is an empty string in Oracle
>>>>>> +    elif distro_lower.startswith('oracle linux'):
>>>>>> +        codename = 'OL' + release
>>>>>> +    elif distro_lower.startswith('oracle vm'):
>>>>>> +        codename = 'OVS' + release
>>>>>>           return (
>>>>>>             str(distro).rstrip(),
>>>>>> diff --git
>>>>>> a/src/ceph-detect-init/ceph_detect_init/oraclevms/__init__.py
>>>>>> b/src/ceph-detect-init/ceph_detect_init/oraclevms/__init__.py
>>>>>> new file mode 100644
>>>>>> index 0000000..f7bf85b
>>>>>> --- /dev/null
>>>>>> +++ b/src/ceph-detect-init/ceph_detect_init/oraclevms/__init__.py
>>>>>> @@ -0,0 +1,11 @@
>>>>>> +distro = None
>>>>>> +release = None
>>>>>> +codename = None
>>>>>> +
>>>>>> +
>>>>>> +def choose_init():
>>>>>> +    """Select a init system
>>>>>> +
>>>>>> +    Returns the name of a init system (upstart, sysvinit ...).
>>>>>> +    """
>>>>>> +    return 'sysvinit'
>>>>>> diff --git a/src/ceph-detect-init/tests/test_all.py
>>>>>> b/src/ceph-detect-init/tests/test_all.py
>>>>>> index d2733c3..eb48bb4 100644
>>>>>> --- a/src/ceph-detect-init/tests/test_all.py
>>>>>> +++ b/src/ceph-detect-init/tests/test_all.py
>>>>>> @@ -35,6 +35,7 @@ from ceph_detect_init import suse
>>>>>>     from ceph_detect_init import gentoo
>>>>>>     from ceph_detect_init import freebsd
>>>>>>     from ceph_detect_init import docker
>>>>>> +from ceph_detect_init import oraclevms
>>>>>>       logging.basicConfig(format='%(asctime)s %(levelname)s
>>>>>> %(message)s',
>>>>>>                         level=logging.DEBUG)
>>>>>> @@ -54,6 +55,9 @@ class TestCephDetectInit(testtools.TestCase):
>>>>>>         def test_docker(self):
>>>>>>             self.assertEqual('none', docker.choose_init())
>>>>>>     +    def test_oraclevms(self):
>>>>>> +        self.assertEqual('sysvinit', oraclevms.choose_init())
>>>>>> +
>>>>>>         def test_centos(self):
>>>>>>             with mock.patch('ceph_detect_init.centos.release',
>>>>>>                             '7.0'):
>>>>>> @@ -207,6 +211,8 @@ class TestCephDetectInit(testtools.TestCase):
>>>>>>             self.assertEqual(debian, g('ubuntu'))
>>>>>>             self.assertEqual(centos, g('centos'))
>>>>>>             self.assertEqual(centos, g('scientific'))
>>>>>> +        self.assertEqual(centos, g('Oracle Linux Server'))
>>>>>> +        self.assertEqual(oraclevms, g('Oracle VM server'))
>>>>>>             self.assertEqual(fedora, g('fedora'))
>>>>>>             self.assertEqual(suse, g('suse'))
>>>>>>             self.assertEqual(rhel, g('redhat', use_rhceph=True))
>>>>>> @@ -222,6 +228,8 @@ class TestCephDetectInit(testtools.TestCase):
>>>>>>             self.assertEqual('scientific', n('Scientific'))
>>>>>>             self.assertEqual('scientific', n('Scientific Linux'))
>>>>>>             self.assertEqual('scientific', n('scientific linux'))
>>>>>> +        self.assertEqual('oraclel', n('Oracle Linux Server'))
>>>>>> +        self.assertEqual('oraclevms', n('Oracle VM server'))
>>>>>>             self.assertEqual('suse', n('SUSE'))
>>>>>>             self.assertEqual('suse', n('suse'))
>>>>>>             self.assertEqual('suse', n('openSUSE'))
>>>>>> @@ -266,6 +274,16 @@ class TestCephDetectInit(testtools.TestCase):
>>>>>>                 self.assertEqual(('debian', 'sid/jessie', 'sid'),
>>>>>>                                 
>>>>>> ceph_detect_init.platform_information())
>>>>>>     +        with mock.patch('platform.linux_distribution',
>>>>>> +                        lambda **kwargs: (('Oracle Linux Server',
>>>>>> '7.3', ''))):
>>>>>> +            self.assertEqual(('Oracle Linux Server', '7.3', 'OL7.3'),
>>>>>> +                             ceph_detect_init.platform_information())
>>>>>> +
>>>>>> +        with mock.patch('platform.linux_distribution',
>>>>>> +                        lambda **kwargs: (('Oracle VM server',
>>>>>> '3.4.2', ''))):
>>>>>> +            self.assertEqual(('Oracle VM server', '3.4.2',
>>>>>> 'OVS3.4.2'),
>>>>>> +                             ceph_detect_init.platform_information())
>>>>>> +
>>>>>>         @mock.patch('platform.linux_distribution')
>>>>>>         def test_platform_information_container(self, mock_linux_dist):
>>>>>>             import sys
>>>>>>
>>>> -- 
>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


From: Nikita Gerasimov <nikita.gerasimov@oracle.com>
Subject: Re: [PATCH] ceph-detect-init: Adds Oracle Linux Server and Oracle VM
 Server detection
Date: Tue, 28 Feb 2017 19:35:35 +0300
Message-ID: <91452243-7cb1-21b0-3254-48ab39d6cfb8@oracle.com>
References: <1488218767-14618-1-git-send-email-nikita.gerasimov@oracle.com>
 <24250ac1-e3fb-f68a-9ecd-fd0763178c74@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from userp1050.oracle.com ([156.151.31.82]:48211 "EHLO
        userp1050.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751387AbdB1SI4 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Feb 2017 13:08:56 -0500
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
        by userp1050.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id v1SGarKE021796
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <ceph-devel@vger.kernel.org>; Tue, 28 Feb 2017 16:36:54 GMT
In-Reply-To: <24250ac1-e3fb-f68a-9ecd-fd0763178c74@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>, ceph-devel@vger.kernel.org

Hi,

Nope, this patch contain an error, will send another.


On 27.02.2017 21:25, Loic Dachary wrote:
> Hi,
>
> Do you confirm it passes make check ?
>
> Thanks !
>
> On 02/27/2017 07:06 PM, nikita.gerasimov@oracle.com wrote:
>> From: Nikita Gerasimov <nikita.gerasimov@oracle.com>
>>
>> Oracle Linux Server is API/ABI compatible with RHEL/CentOS Linux distro.
>> Oracle VM Server is Xen based VM server. Which modern versions Dom0 is based on Oracle Linux 6
>>
>> Signed-off-by: Nikita Gerasimov <nikita.gerasimov@oracle.com>
>> ---
>>   src/ceph-detect-init/ceph_detect_init/__init__.py      | 18 ++++++++++++++++--
>>   .../ceph_detect_init/oraclevm/__init__.py              | 11 +++++++++++
>>   src/ceph-detect-init/tests/test_all.py                 |  8 ++++++++
>>   3 files changed, 35 insertions(+), 2 deletions(-)
>>   create mode 100644 src/ceph-detect-init/ceph_detect_init/oraclevm/__init__.py
>>
>> diff --git a/src/ceph-detect-init/ceph_detect_init/__init__.py b/src/ceph-detect-init/ceph_detect_init/__init__.py
>> index aad3eee..c057409 100644
>> --- a/src/ceph-detect-init/ceph_detect_init/__init__.py
>> +++ b/src/ceph-detect-init/ceph_detect_init/__init__.py
>> @@ -24,6 +24,7 @@ from ceph_detect_init import suse
>>   from ceph_detect_init import gentoo
>>   from ceph_detect_init import freebsd
>>   from ceph_detect_init import docker
>> +from ceph_detect_init import oraclevm
>>   import os
>>   import logging
>>   import platform
>> @@ -44,7 +45,8 @@ def get(use_rhceph=False):
>>       module.normalized_name = _normalized_distro_name(distro_name)
>>       module.distro = module.normalized_name
>>       module.is_el = module.normalized_name in ['redhat', 'centos',
>> -                                              'fedora', 'scientific']
>> +                                              'fedora', 'scientific',
>> +                                              'oraclel']
>>       module.release = release
>>       module.codename = codename
>>       module.init = module.choose_init()
>> @@ -64,6 +66,8 @@ def _get_distro(distro, use_rhceph=False):
>>           'linuxmint': debian,
>>           'centos': centos,
>>           'scientific': centos,
>> +        'oraclel': centos,
>> +        'oraclevm': oraclevm,
>>           'redhat': centos,
>>           'fedora': fedora,
>>           'suse': suse,
>> @@ -90,6 +94,10 @@ def _normalized_distro_name(distro):
>>           return 'suse'
>>       elif distro.startswith('centos'):
>>           return 'centos'
>> +    elif distro.startswith('oracle linux'):
>> +        return 'oraclel'
>> +    elif distro.startswith('oracle vm'):
>> +        return 'oraclevm'
>>       elif distro.startswith(('gentoo', 'funtoo', 'exherbo')):
>>           return 'gentoo'
>>       return distro
>> @@ -128,7 +136,8 @@ def platform_information():
>>           raise exc.UnsupportedPlatform(platform.system(), '', '')
>>   
>>       # this could be an empty string in Debian
>> -    if not codename and 'debian' in distro.lower():
>> +    distro_lower = distro.lower()
>> +    if not codename and 'debian' in distro_lower:
>>           debian_codenames = {
>>               '8': 'jessie',
>>               '7': 'wheezy',
>> @@ -136,6 +145,11 @@ def platform_information():
>>           }
>>           major_version = release.split('.')[0]
>>           codename = debian_codenames.get(major_version, '')
>> +    # this is an empty string in Oracle
>> +    elif distro_lower.startswith('oracle linux'):
>> +        codename = 'OL' + release
>> +    elif distro_lower.startswith('oracle vm'):
>> +        codename = 'OVM' + release
>>   
>>           # In order to support newer jessie/sid or wheezy/sid strings
>>           # we test this if sid is buried in the minor, we should use
>> diff --git a/src/ceph-detect-init/ceph_detect_init/oraclevm/__init__.py b/src/ceph-detect-init/ceph_detect_init/oraclevm/__init__.py
>> new file mode 100644
>> index 0000000..f7bf85b
>> --- /dev/null
>> +++ b/src/ceph-detect-init/ceph_detect_init/oraclevm/__init__.py
>> @@ -0,0 +1,11 @@
>> +distro = None
>> +release = None
>> +codename = None
>> +
>> +
>> +def choose_init():
>> +    """Select a init system
>> +
>> +    Returns the name of a init system (upstart, sysvinit ...).
>> +    """
>> +    return 'sysvinit'
>> diff --git a/src/ceph-detect-init/tests/test_all.py b/src/ceph-detect-init/tests/test_all.py
>> index d2733c3..d621943 100644
>> --- a/src/ceph-detect-init/tests/test_all.py
>> +++ b/src/ceph-detect-init/tests/test_all.py
>> @@ -35,6 +35,7 @@ from ceph_detect_init import suse
>>   from ceph_detect_init import gentoo
>>   from ceph_detect_init import freebsd
>>   from ceph_detect_init import docker
>> +from ceph_detect_init import oraclevm
>>   
>>   logging.basicConfig(format='%(asctime)s %(levelname)s %(message)s',
>>                       level=logging.DEBUG)
>> @@ -54,6 +55,9 @@ class TestCephDetectInit(testtools.TestCase):
>>       def test_docker(self):
>>           self.assertEqual('none', docker.choose_init())
>>   
>> +    def test_oraclevm(self):
>> +        self.assertEqual('sysvinit', oraclevm.choose_init())
>> +
>>       def test_centos(self):
>>           with mock.patch('ceph_detect_init.centos.release',
>>                           '7.0'):
>> @@ -207,6 +211,8 @@ class TestCephDetectInit(testtools.TestCase):
>>           self.assertEqual(debian, g('ubuntu'))
>>           self.assertEqual(centos, g('centos'))
>>           self.assertEqual(centos, g('scientific'))
>> +        self.assertEqual(centos, g('Oracle Linux Server'))
>> +        self.assertEqual(oraclevm, g('Oracle VM server'))
>>           self.assertEqual(fedora, g('fedora'))
>>           self.assertEqual(suse, g('suse'))
>>           self.assertEqual(rhel, g('redhat', use_rhceph=True))
>> @@ -222,6 +228,8 @@ class TestCephDetectInit(testtools.TestCase):
>>           self.assertEqual('scientific', n('Scientific'))
>>           self.assertEqual('scientific', n('Scientific Linux'))
>>           self.assertEqual('scientific', n('scientific linux'))
>> +        self.assertEqual('oraclel', n('Oracle Linux Server'))
>> +        self.assertEqual('oraclevm', n('Oracle VM server'))
>>           self.assertEqual('suse', n('SUSE'))
>>           self.assertEqual('suse', n('suse'))
>>           self.assertEqual('suse', n('openSUSE'))
>>


From: Udo Seidel <udoseidel@gmx.de>
Subject: Re: Compilation issues on Fedora 13 and Fedora 15
Date: Sat, 14 Apr 2012 02:30:38 +0200 (CEST)
Message-ID: <alpine.LFD.2.02.1204140209460.13159@stderr.seidelnet.de>
References: <1332665829.7312.8.camel@indica.cc.iitb.ac.in>  <1332689005.2102.3.camel@jdlaptop.lesbg.loc> <1334337873.17237.13.camel@indica.cc.iitb.ac.in>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463809791-85403757-1334363439=:13159"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.22]:39735 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1757263Ab2DNAan (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 13 Apr 2012 20:30:43 -0400
In-Reply-To: <1334337873.17237.13.camel@indica.cc.iitb.ac.in>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ajit K Jena <ajit@iitb.ac.in>
Cc: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463809791-85403757-1334363439=:13159
Content-Type: TEXT/PLAIN; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8BIT


Hi Ajit,
I have successfully built 0.43 and 0.45 on Fedora 16 (last Fedora updates 
installed on Thursday). I suggest to try again with either of these 
versions. I have used the src.rpm packages from here: 
kojipkgs.fedoraproject.org/packages/ceph/
Good luck,
Udo

P.S. The "last lines" from the second build ...
....
c++.so.6(GLIBCXX_3.4.11)(64bit) libstdc++.so.6(GLIBCXX_3.4.15)(64bit) 
libstdc++.so.6(GLIBCXX_3.4.9)(64bit) libuuid.so.1()(64bit) 
libuuid.so.1(UUID_1.0)(64bit) rtld(GNU_HASH)
Processing files: ceph-debuginfo-0.45-1.fc16.x86_64
Prüfe auf nicht gepackte Datei(en): /usr/lib/rpm/check-files 
/home/udo/RPM/BUILDROOT/ceph-0.45-1.fc16.x86_64
Erstellt: /home/udo/RPM/RPMS/x86_64/ceph-0.45-1.fc16.x86_64.rpm
Erstellt: /home/udo/RPM/RPMS/x86_64/ceph-fuse-0.45-1.fc16.x86_64.rpm
Erstellt: /home/udo/RPM/RPMS/x86_64/ceph-devel-0.45-1.fc16.x86_64.rpm
Erstellt: /home/udo/RPM/RPMS/x86_64/ceph-radosgw-0.45-1.fc16.x86_64.rpm
Erstellt: /home/udo/RPM/RPMS/x86_64/ceph-obsync-0.45-1.fc16.x86_64.rpm
Erstellt: /home/udo/RPM/RPMS/x86_64/ceph-gcephtool-0.45-1.fc16.x86_64.rpm
Erstellt: /home/udo/RPM/RPMS/x86_64/ceph-debuginfo-0.45-1.fc16.x86_64.rpm
Ausführung(%clean): /bin/sh -e /home/udo/RPM/tmp/rpm-tmp.22RqVS
+ umask 022
+ cd /home/udo/RPM/BUILD
+ cd ceph-0.45
+ /bin/rm -rf /home/udo/RPM/BUILDROOT/ceph-0.45-1.fc16.x86_64
+ exit 0



On Fri, 13 Apr 2012, Ajit K Jena wrote:

> Hi CEPH Developers,
>
> Thanks for your responses. I have been trying your suggestions one
> after another. Sorry to report that none of the suggestions work
> for me.
>
> Looks like FEDORA is not fit for CEPH experimentation anymore !!
> The source RPM for 0.43 and above simply does not build on
> FC1[356]. I am not so sure about FC17 since it may bring a host of
> other hidden problems.
>
> Can any one pl let me know what other distros one should look at ?
> I am really not keen about trying UBUNTU or other DEBIAN derivatives.
> What about CENTOS 6.[012] ?
>
> Thanks for your help.
>
> --ajit
>
> On Sun, 2012-03-25 at 18:23 +0300, Jonathan Dieter wrote:
>> On Sun, 2012-03-25 at 14:27 +0530, Ajit K Jena wrote:
>>> Hello All,
>>>
>>> I have lost touch with the growth of ceph after version 0.30.
>>> I am trying to compile version 0.43 and 0.44 on FC13 and FC15.
>>
>> FWIW, we've pushed 0.43 in Fedora 17. We don't have anything later than
>> 0.41 in versions lower than 17 because of Fedora's updates policies.
>>
>> However, you could take the source rpm from F17 and rebuild it for older
>> versions of Fedora.
>>
>> It's available at
>> http://kojipkgs.fedoraproject.org/packages/ceph/0.43/1.fc17/src/ceph-0.43-1.fc17.src.rpm
>>
>> I'll probably push 0.44 to F17 once I manage to get the RPM built.
>>
>> Jonathan
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
---1463809791-85403757-1334363439=:13159--

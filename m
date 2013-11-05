From: Alphe Salas Michels <asalas@kepler.cl>
Subject: Re: writing a ceph cliente for MS windows
Date: Tue, 05 Nov 2013 14:40:15 -0300
Message-ID: <52792D7F.20500@kepler.cl>
References: <52780140.6090409@kepler.cl> <alpine.DEB.2.00.1311050608020.17874@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f48.google.com ([209.85.216.48]:33505 "EHLO
	mail-qa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751519Ab3KERkT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 5 Nov 2013 12:40:19 -0500
Received: by mail-qa0-f48.google.com with SMTP id w8so1224884qac.14
        for <ceph-devel@vger.kernel.org>; Tue, 05 Nov 2013 09:40:19 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1311050608020.17874@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org


signature *Hi, Sage !
thank you for you enthousiast reply.
I sure want to make the best use of everything or anything previously 
done to tend to
write ceph cliente for windows.

Apart using libre tools for building the future ceph cliente I am open 
to anything.
I would recommand eclipse CDT or Code::BLocks they are based on mingwin 
open and easyly enhanceable.**

more free tools can be found here:
http://www.freebyte.com/programming/cpp/#cppcompilers


I will read libcephfs source code and take some notes about the protocol.
I was more going from what I know and trying to track down how 
mount.ceph work with the parameters passed to it.
since it point finally to Kernel/fs/ceph and that I don t really 
understand how that module work and that it probably points to some 
other dependencies Reading libcephfs source code could be a big gain of 
time.

basically on the protocol what is  need are:

1) open and maintain a connection (socket open, auth, etc )
2) retreive a map of directories and disk Quota (disk sizing Y TB free,  
Z TB total)
3) procedure to send files / directories in a maner that it will allow 
our client to fit ceph transmission protocols
(limit bandwith for stability?, limit connection amount?, limit cpu 
use?, Cache for preparing data transfer (a FIFO cache)?)
4)Procedure to retreive files / directory from ceph cluster
5) Management copy/move files /Directories, FS stats, Connection Stats. 
logging.

My idea to progress is to take those main bulletpoint in ceph protocol 
based on general ideas of what ceph file system does and start 
identifying parts from libcephfs to match those "needs".

Any suggestion and contributions are welcome.


*
On 11/05/13 11:23, Sage Weil wrote:
> Hi Alphe,
>
> On Mon, 4 Nov 2013, Alphe Salas Michels wrote:
>> Good day developers!
>>
>> I would like to propose to the one interested  work with me to develop a ceph
>> cliente for MS windows world, Basing us on dokanFS.
>>
>> My company is a ceph enthousiast that use on a dayly basis ceph and that need
>> both transfer speed and big expendable and cheap storage.
>> My company is specialised in data recovery and we want to participate to ceph
>> effort by bringing a ceph cliente for windows.
> Awesome!
>
>> Our experience shows us that the best gateway is each clientes being its own
>> gateway, instead of having a bottle neck server or a cluster of bottle neck
>> servers as gateway (FTP, samba, SFTP,webdav, s3, etc..).
>>
>> We already did some research in that domain.
>>
>> Dokan FS is an intent  to write an opensource fuse like cliente for MS
>> windows.
>>
>> More information on DOKANFS can be triggered here
>> http://dokan-dev.net/en/download/
>>
>> Positive points of using DOKANFS.
>>
>> - its opensourced and well licenced mit licence, gpl licence and lgpl licence.
>>
>> Negative point of using DOKAN FS.
>> - unreachable author
>> - Poor documentation . Dev comments in japanese.
>> - Work in progress so it is unstable and needs to be updated, debugged and
>> maintained by a MS Windows file system expert developper.
> I am not very familiar with windows storage APIs, but somebody told me
> at once point there were several interfaces against which a new file
> system could be implemented, everything from a full in-kernel driver to
> something that is explorer-based.  Are any of those suitable?  Using a
> potentially abandoned fuse-like layer makes me a bit nervous.
>
> That said,
>   
>> I try past year to do a merge from ceph-fuse to dokanfs
>> here are what I learnt.
>> - Ceph-fuse and related source code is around 60 000 lines of code.
>> - Ceph protocol isn t documented so it is like trying to draw a map of america
>> using only a sextan and a compass.
>>
>> Those led me to those conclusions:
>> - I can t do it alone.
>> - It is easier to draw down the ceph protocol way to work from kernel/fs/ceph
>> sources and mount.ceph
>> - Ceph depending libraries may be unexistant or not up to date in their port
>> on MS Windows (cygwin)
> I think the most sane path should be to make libcephfs sufficiently
> portable to build on windows (or cygwin).  For the bits used by the
> client-side coe, I don't think there should be much in the way of
> dependencies, and the main challenge would be untangling the build for
> the necessary pieces out from the rest of Ceph.
>
> Have you seen the wip-port portability work that is currently underway by
> Noah and Alan?  That may solve many of the cygwin problems you are seeing
> today.
>
>> - MS file system specialist are hard do find in the "open source libre world"
>> so I will try in the commercial world.
>>
>> The commercial world has some problems too. They need ceph protocol draft to
>> implemente it to their own product They will have licencing /commercial
>> politics that infringe lgpl, and hide that most of the work is done by people
>> other than them. They will not participate in a financial way to ceph
>> enhancement and growth.
> I don't think reimplementing the client code is an efficient way forward.
> Unless the goal is a pure kernel implementation...but a significant
> ongoing investment in development resources would be needed for that going
> forward.  I suspect that is a challenge for a platform that does not
> typically rally that sort of community effort.
>
> The easiest thing is of course just to use CIFS and Samba (which works
> today).  A fuse-like approach is probably a reasonably middle ground (both
> in initial effort and maintainability going forward)...
>
> sage
>
>


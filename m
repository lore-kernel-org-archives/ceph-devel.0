From: Joao Eduardo Luis <joao.luis@inktank.com>
Subject: Re: FW: errno=Connection refused
Date: Tue, 26 Mar 2013 15:09:11 +0000
Message-ID: <5151BA17.90103@inktank.com>
References: <DUB116-W2072C51403FEC6645453AAE0D00@phx.gbl> <DUB116-W933F690F6A1AB8C2998E43E0D00@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:64892 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934557Ab3CZPJh (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 26 Mar 2013 11:09:37 -0400
Received: by mail-wi0-f171.google.com with SMTP id hn17so1016203wib.16
        for <ceph-devel@vger.kernel.org>; Tue, 26 Mar 2013 08:09:36 -0700 (PDT)
In-Reply-To: <DUB116-W933F690F6A1AB8C2998E43E0D00@phx.gbl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: charles L <charlesboy009@hotmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 03/26/2013 02:33 PM, charles L wrote:
> ----------------------------------------
>> From: charlesboy009@hotmail.com
>> To: ceph-users@ceph.com
>> Subject: errno=Connection refused
>> Date: Tue, 26 Mar 2013 11:26:03 +0100
>>
>> Hi,
>>
>> Can somebody help?
>>
>> git clone --recursive https://github.com/ceph/ceph.git
>> Cloning into 'ceph'...
>> remote: Counting objects: 179817, done.
>> remote: Compressing objects: 100% (34122/34122), done.
>> remote: Total 179817 (delta 146077), reused 177377 (delta 143959)
>> Receiving objects: 100% (179817/179817), 35.42 MiB | 136 KiB/s, done.
>> Resolving deltas: 100% (146077/146077), done.
>> Submodule 'ceph-object-corpus' (git://ceph.com/git/ceph-object-corpus.git) registered for path 'ceph-object-corpus'
>> Submodule 'src/libs3' (git://github.com/ceph/libs3.git) registered for path 'src/libs3'
>> Cloning into 'ceph-object-corpus'...
>> fatal: unable to connect to ceph.com:
>> ceph.com[0: 208.113.241.137]: errno=Connection refused
>>
>> Clone of 'git://ceph.com/git/ceph-object-corpus.git' into submodule path 'ceph-object-cor pus' failed
>>

Works for me.  Maybe some temporary connection error?  Are you able to 
access 'ceph.com' from wherever you are?

   -Joao

$ git clone --recursive https://github.com/ceph/ceph.git
Cloning into 'ceph'...
remote: Counting objects: 180035, done.
remote: Compressing objects: 100% (34122/34122), done.
remote: Total 180035 (delta 146255), reused 177644 (delta 144177)
Receiving objects: 100% (180035/180035), 35.46 MiB | 1.51 MiB/s, done.
Resolving deltas: 100% (146255/146255), done.
Submodule 'ceph-object-corpus' 
(git://ceph.com/git/ceph-object-corpus.git) registered for path 
'ceph-object-corpus'
Submodule 'src/libs3' (git://github.com/ceph/libs3.git) registered for 
path 'src/libs3'
Cloning into 'ceph-object-corpus'...
remote: Counting objects: 6250, done.
remote: Compressing objects: 100% (3459/3459), done.
remote: Total 6250 (delta 772), reused 6101 (delta 654)
Receiving objects: 100% (6250/6250), 735.47 KiB | 305 KiB/s, done.
Resolving deltas: 100% (772/772), done.
Submodule path 'ceph-object-corpus': checked out 
'0655429f62bc3366250496da3513abec15c34856'
Cloning into 'src/libs3'...
remote: Counting objects: 1000, done.
remote: Compressing objects: 100% (289/289), done.
remote: Total 1000 (delta 720), reused 976 (delta 696)
Receiving objects: 100% (1000/1000), 347.92 KiB | 262 KiB/s, done.
Resolving deltas: 100% (720/720), done.
Submodule path 'src/libs3': checked out 
'9dc3a9c683385abfe4ad92b7c6ff30719acc3c13'



>>
>> Thanks. 		 	   		  --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


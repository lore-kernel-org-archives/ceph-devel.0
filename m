From: Dan Mick <dmick@redhat.com>
Subject: Re: tracker.ceph.com API
Date: Mon, 09 Feb 2015 13:27:59 -0800
Message-ID: <54D9265F.2070808@redhat.com>
References: <54ABC3E5.7040704@dachary.org> <54D5D5B2.8060203@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52493 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755839AbbBIV3D (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 9 Feb 2015 16:29:03 -0500
In-Reply-To: <54D5D5B2.8060203@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>, Ceph Development <ceph-devel@vger.kernel.org>

Serves you right for voluntarily using XML :-P


On 02/07/2015 01:06 AM, Loic Dachary wrote:
> 
> 
> On 06/01/2015 12:15, Loic Dachary wrote:
>> Hi,
>>
>> I tried various things to update tracker.ceph.com from the command line but failed. The best result I have is the following:
>>
>> cat /tmp/a.xml
>>
>> <issue>
>>   <id>10281</id>
>>   <subject>firefly: make check fails on fedora 20 (1)</subject>
>>   <custom_fields type="array">
>>     <custom_field name="Backport" id="2">
>>       <value>firefly</value>
>>     </custom_field>
>>   </custom_fields>
>> </issue>
>>
>> curl --http1.0 --verbose -T /tmp/a.xml http://tracker.ceph.com/issues/10281.xml?key=cd9a99820b4e7543a
> 
> The content-type was missing:
> 
> curl --http1.0 --verbose --header 'Content-type: application/xml' -T /tmp/a.xml http://tracker.ceph.com/issues/10281.xml?key=cd9a99820b4e7543a
> 
> works :-)
> 
>>
>> * Hostname was NOT found in DNS cache
>> *   Trying 64.90.32.38...
>> * Connected to tracker.ceph.com (64.90.32.38) port 80 (#0)
>>> PUT /issues/10281.xml?key=cd9a99820b4e7543a3c HTTP/1.0
>>> User-Agent: curl/7.35.0
>>> Host: tracker.ceph.com
>>> Accept: */*
>>> Content-Length: 239
>>>
>> * We are completely uploaded and fine
>> < HTTP/1.1 200 OK
>> < Date: Tue, 06 Jan 2015 11:05:55 GMT
>> * Server Apache/2.2.22 (Ubuntu) is not blacklisted
>> < Server: Apache/2.2.22 (Ubuntu)
>> < X-Powered-By: Phusion Passenger (mod_rails/mod_rack) 3.0.13
>> < X-UA-Compatible: IE=Edge,chrome=1
>> < Cache-Control: no-cache
>> < X-Request-Id: eb302e17961997bafade5739f48a7183
>> < X-Runtime: 1.375926
>> < X-Rack-Cache: invalidate, pass
>> < Set-Cookie: _redmine_session=BAh7BkkiD3Nlc3Npb25faWQGOgZFRkkZTIwY2Y5NWYzYTE5BjsAVA%3D%3D--a2a2fd48f300f5c8c9; path=/; HttpOnly
>> < Set-Cookie: autologin=; path=/; expires=Thu, 01-Jan-1970 00:00:00 GMT
>> < Status: 200
>> < Content-Length: 0
>> < Connection: close
>> < Content-Type: application/xml; charset=utf-8
>> <
>> * Closing connection 0
>>
>> but most of the time I get:
>>
>> * Hostname was NOT found in DNS cache
>> *   Trying 64.90.32.38...
>> * Connected to tracker.ceph.com (64.90.32.38) port 80 (#0)
>>> PUT /issues/10281.xml?key=cd9a99820b4e7543a3ce82febce4970b3dfb6b86 HTTP/1.0
>>> User-Agent: curl/7.35.0
>>> Host: tracker.ceph.com
>>> Accept: */*
>>> Content-Length: 239
>>>
>> * We are completely uploaded and fine
>> * Empty reply from server
>> * Connection #0 to host tracker.ceph.com left intact
>>
>> Am I doing something wrong ?
>>
>> Cheers
>>
> 


-- 
Dan Mick
Red Hat, Inc.
Ceph docs: http://ceph.com/docs

From: Matt Benjamin <mbenjamin@redhat.com>
Subject: Re: [michigan-eng] cmake and gitbuilder, juntos
Date: Mon, 3 Aug 2015 17:56:25 -0400 (EDT)
Message-ID: <254861369.1455639.1438638985288.JavaMail.zimbra@redhat.com>
References: <1282096535.1448307.1438636898144.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx4-phx2.redhat.com ([209.132.183.25]:40765 "EHLO
	mx4-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932332AbbHCV4Z (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 3 Aug 2015 17:56:25 -0400
In-Reply-To: <1282096535.1448307.1438636898144.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: michigan-eng@redhat.com
Cc: ceph-devel@vger.kernel.org

(fyi, ceph-devel, this was irc discussion about enhancing gitbuilder, a temporary blocker for cmake)

(05:36:09 PM) sjusthm: sage mattbenjamin: so that means we should adapt gitbuilder to use cmake, right?
(05:36:17 PM) sjusthm: in the immediate term?
(05:36:23 PM) sjusthm: since we want to switch to cmake anyway
(05:36:26 PM) sjusthm: and we need it for C++11?
(05:39:50 PM) mattbenjamin: sjustm:  that sounds correct
<snippage>
(05:47:44 PM) sjusthm: mattbenjamin: oh, I'd be fine with doing cmake first
(05:47:52 PM) sjusthm: no one actually *likes* messing with automake

----- Original Message -----
From: "Matt Benjamin" <mbenjamin@redhat.com>
To: michigan-eng@redhat.com
Sent: Monday, August 3, 2015 5:21:38 PM
Subject: [michigan-eng] cmake and gitbuilder, juntos

(04:53:04 PM) mattbenjamin: gitbuilder doesn't understand cmake;  I heard someone (sam?) talk about gitbiulder eol--but that's not soon?
(04:54:45 PM) mattbenjamin: this is appropo of:  casey's c++11 change includes automake logic to get around that
(04:58:44 PM) sage: mattbenjamin: yeah, we'll need tdo change all of the build tooling (gitbuilder and ceph-build.git) to use cmake
(04:58:54 PM) mattbenjamin: ok
(04:59:01 PM) sage: it'll be a while before we phase out gitbuidler
(04:59:51 PM) joshd: mattbenjamin: gitbuilder just runs a script you give it - it has no knowledge of build systems. it'll involve replacing parts of scripts like https://github.com/ceph/autobuild-ceph/blob/master/build-ceph.sh
(05:00:48 PM) mattbenjamin: tx
(05:01:01 PM) haomaiwang left the room (quit: Remote host closed the connection).


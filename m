From: Mark Nelson <mnelson@redhat.com>
Subject: Re: BP for changes in CBT
Date: Fri, 24 Jul 2015 07:43:27 -0500
Message-ID: <55B232EF.7080004@redhat.com>
References: <CACxKWayZ-E477ntU9PQZ3Ot2KjVwwficVQd2CAhKSUYGKuZM1w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:41479 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752550AbbGXMn3 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 24 Jul 2015 08:43:29 -0400
In-Reply-To: <CACxKWayZ-E477ntU9PQZ3Ot2KjVwwficVQd2CAhKSUYGKuZM1w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Konstantin Danilov <kdanilov@mirantis.com>, ceph-devel@vger.kernel.org

Hi Konstantin,

It might be best to move this to the cbt mailing list for discussion so 
that we don't end up filling up ceph-devel.  Would you mind re-posting 
there?

Mark

On 07/24/2015 07:21 AM, Konstantin Danilov wrote:
> Hi all,
> This is BP/summary for changes in cbt, we discuss on previous week.
> Do I need to register it somewhere?
>
> Functional Goals
> ================
>
> Primary
> -------
>
> * Allow to test any block-storage device with same code
> * Add openstack and FUEL support
> * Allow to iterate tests on any parameter from configuration
> * Add graph reports and statistic result processing
> * Improve UX : make a package, put on pypi, allow to be installed
>    with pip; make docker image, put into docker images storage
>
> Secondary
> ---------
>
> * Allow to execute in non-transitive networks
>    (where node A can connect to node B,
>    node B can connect to node C,
>    but node A can't connect to node C). This is often in
>    production environments
> * Allow to fio task files for load description interchangeably
>    with yaml description
> * Give roles to all discovered nodes to selectively run a
>    tests and gather resource usage info
> * Allow to split configuration on parts
> * Add support for hight-level tests - TCP, SPC-1
> * Gather cluster(s) hardware and software configuration
> * Allow to override configuration settings from command-line
> * Add fio based tester, which uses fio tasks (as not all
>    parameters can be passed with cmd line)
>
> Structural goals
> ================
>
> * Make code more pep-8 complaint
> * Make a package and change all local import relative
> * Allow to execute tests without bare minimum of packages
> * Replace print with logging
> * Store all test results in results directory
> * Add ssh key support on node login
> * Remove lxml dependency (xml.etree have all requires functions)
>
> Changes
> =======
>
> Split code on stages. Each stage is a class:
>
>      class IStage(object):
>          def enter(self, context, config):
>              pass
>
>          def next_iteration(self, context, old_config, new_config):
>              pass
>
>          def exit(self, context, config):
>              pass
>
> Stages are executed in order one-by-one. Each stages has
> a separated part in configuraion, named after stage class.
>
> There a way to mark value in a configuration as an array of
> values for cycle. Stages manage logic analyze configuration
> and executes stages, selecting values from configuration in cycle.
>
> Example:
> In this example each stage get only it part of config,
> but in real code it would gets entire config.
> '__' - marks cycle in config file.
>
> Config file:
>
>      Stage1:
>          val1: __, [1, 2]
>      Stage2:
>          val2: 7
>      Stage3:
>          val3: __, [11, 12]
>          val4: __, [21, 22]
>
> Execution order:
>
>      Stage1.enter({val1:1})
>      Stage2.enter({val2:7})
>
>      Stage3.enter({val3:11, val4:21})
>      Stage3.reenter({val3:11, val4:21}, {val3:11, val4:22})
>      Stage3.reenter({val3:11, val4:22}, {val3:12, val4:21})
>      Stage3.reenter({val3:12, val4:21}, {val3:12, val4:22})
>      Stage3.exit({val3:12, val4:22})
>
>      Stage2.exit({val2:7})
>      Stage3.reenter({val1:1}, {val1:2})
>      Stage2.enter({val2:7})
>
>      Stage3.enter({val3:11, val4:21})
>      Stage3.reenter({val3:11, val4:21}, {val3:11, val4:22})
>      Stage3.reenter({val3:11, val4:22}, {val3:12, val4:21})
>      Stage3.reenter({val3:12, val4:21}, {val3:12, val4:22})
>      Stage3.exit({val3:12, val4:22})
>
>      Stage2.exit({val2:7})
>      Stage3.exit({val1:2})
>
>
> Execution goes up and down on tree, and don't skip stages.
> Special reenter method allows stage to optimize configuration update.
> Cycles need to be specially marked to separate array as one
> value from array as list of values. Cycles, embedded in arrays
> aren't supported.
>
> The first parameter, passed to each stage method is a context object.
> This is common storage for stage results, used to pass data between
> stages.
>
>
> Stage list:
>
>      Discover hardware or explicit nodes
>      Discover FUEL nodes
>      Discover openstack nodes
>      Discover openstack VM's
>
>      Deploy ceph
>
>      Start vm on openstack
>      Start sensors - ????
>
>      Run tests
>
>      Result statistical processing
>      Text report
>      Graphical report
>      Sensor data report
>
>
> Allow to execute in non-transitional networks
> ---------------------------------------------
>
> This is very often situation in corporate networks. It can be solved
> with ssh port-forwarding. Where ssh ports from all nodes, invisible
> from main node are mapped on ports on some node, visible from main.
>
> Thanks
>
